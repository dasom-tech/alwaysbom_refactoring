package com.flo.alwaysbom.main.controller;

import com.flo.alwaysbom.main.vo.AdminVo;
import com.flo.alwaysbom.fclass.service.FclassService;
import com.flo.alwaysbom.fclass.vo.FclassVo;
import com.flo.alwaysbom.main.service.MainService;
import com.flo.alwaysbom.main.vo.MainImage;
import com.flo.alwaysbom.main.vo.MainVo;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@SessionAttributes({"admin"})
public class AdminController {

    private final MainService mainService;
    private final FclassService fclassService;
    private final FileHandler fileHandler;

    @GetMapping("/admin/main")
    public String main(Model model) {
        List<FclassVo> classes = fclassService.findAll();
        MainVo mainConfig = mainService.getConfig();
        model.addAttribute("classes", classes);
        model.addAttribute("mainConfig", mainConfig);
        return "main/b_index";
    }


    @GetMapping("/admin/login")
    public String goLogin(Model model, HttpSession session) throws NoSuchAlgorithmException, InvalidKeySpecException {
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(2048);

        KeyPair keyPair = generator.genKeyPair();
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();
        session.setAttribute("rsaWebKey", privateKey);
        RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

        String publicModulus = publicSpec.getModulus().toString(16);
        String publicExponent = publicSpec.getPublicExponent().toString(16);
        model.addAttribute("publicModulus", publicModulus);
        model.addAttribute("publicExponent", publicExponent);

        return "/admin/login";
    }

    @PostMapping("/admin/login")
    @ResponseBody
    public boolean loginProc(AdminVo adminVo, Model model) {
        try {
            if (adminVo.getId().equals("admin") && adminVo.getPassword().equals("tosmfqha1!")) {
                model.addAttribute("admin", adminVo);
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @GetMapping("/admin/logout")
    public String logoutProc(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "redirect:/admin/main";
    }

//    @RequestMapping(value = "/api/admin/configs", method = RequestMethod.PUT)
    @PostMapping("/api/admin/configs")
    @ResponseBody
    public MainVo updateConfig(List<MultipartFile> image, MainVo mainVo, String[] link, String[] deleted) throws IOException {
        try {
            List<MainImage> list = new ArrayList<>();
            MainVo mainConfig = mainService.getConfig();
            List<MainImage> oldImages = mainConfig.getImages();
            for (int i = 0; i < image.size(); i++) {
                MultipartFile eachImage = image.get(i);
                String eachDeleted = deleted[i];
                String eachPath = null;
                if (eachDeleted.equals("true")) {
                    fileHandler.deleteFile(oldImages.get(i).getPath());
                } else {
                    eachPath = fileHandler.uploadFile(eachImage, oldImages.get(i).getPath(), "/admin/main");
                }
                String eachLink = link[i];

                list.add(new MainImage(i + 1, eachPath, eachLink));
            }

            mainVo.setImages(list);
            System.out.println("mainVo = " + mainVo);

            mainService.updateConfig(mainVo);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mainVo;
    }
}
