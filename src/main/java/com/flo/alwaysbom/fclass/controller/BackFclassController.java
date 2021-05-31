package com.flo.alwaysbom.fclass.controller;

import com.flo.alwaysbom.fclass.service.BranchService;
import com.flo.alwaysbom.fclass.service.FclassService;
import com.flo.alwaysbom.fclass.service.OclassService;
import com.flo.alwaysbom.fclass.service.ScheduleService;
import com.flo.alwaysbom.fclass.vo.*;
import com.flo.alwaysbom.member.vo.MemberVO;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackFclassController {
    private final BranchService branchService;
    private final FclassService fclassService;
    private final ScheduleService scheduleService;
    private final OclassService oclassService;
    private final FileHandler fileHandler;
    private static final Logger logger = LoggerFactory.getLogger(BackFclassController.class);
    private ServletContext context;

    @GetMapping("admin/fclass/orders")
    public String goOrders(Model model) {
        List<String> branchNames = oclassService.findAllBranch();
        model.addAttribute("branchList", branchNames);
        return "fclass/b_orders";
    }

    @GetMapping("admin/fclass/b_classList")
    public String goList(Model model) {
        List<FclassVo> classList = fclassService.findAll();
        List<BranchVo> branchList = branchService.findAll();

        model.addAttribute("classList", classList);
        model.addAttribute("branchList", branchList);

        return "fclass/b_classList";
    }

    @GetMapping("/admin/fclass/addClass")
    public String goAddClass(Model model) {
        model.addAttribute("branchList", branchService.findAll());
        return "fclass/b_addClass";
    }

    @PostMapping("/admin/fclass/addClass")
    public String addClass(Integer[] branches, FclassVo vo, List<MultipartFile> file) throws IOException {
        vo.setImage1(fileHandler.uploadFile(file.get(0), null, "/fclass/class"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), null, "/fclass/class"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), null, "/fclass/class"));
        fclassService.addClass(vo, branches);
        return "redirect:/admin/fclass/b_classList";
    }

    @PostMapping("/admin/fclass/updateClass")
    public String updateClass(FclassVo vo, Integer[] branches, List<MultipartFile> file) throws IOException {
        String oldImg = vo.getImage1();
        vo.setImage1(fileHandler.uploadFile(file.get(0), vo.getImage1(), "/fclass/class"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), vo.getImage2(), "/fclass/class"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), vo.getImage3(), "/fclass/class"));
        String newImg = vo.getImage1();
        int classIdx = vo.getIdx();
        fclassService.updateFclass(vo, branches);
        if (!oldImg.equals(newImg)) {
            oclassService.updateClassImg(newImg, classIdx);
        }

        return "redirect:/admin/fclass/b_classList";
    }

    @PostMapping("/admin/fclass/deleteClass")
    public String deleteClass(Integer idx) throws IOException {
        FclassVo fclassVo = fclassService.deleteFclass(idx);
        fileHandler.deleteFile(fclassVo.getImage1());
        fileHandler.deleteFile(fclassVo.getImage2());
        fileHandler.deleteFile(fclassVo.getImage3());
        return "redirect:/admin/fclass/b_classList";
    }

    @GetMapping("/admin/fclass/classList")
    public String goFclassList(Model model) {
        List<FclassVo> classList = fclassService.findAll();
        List<BranchVo> branchList = branchService.findAll();
        model.addAttribute("classList", classList);
        model.addAttribute("branchList", branchList);
        return "fclass/b_classList";
    }

    @GetMapping("admin/fclass/detail")
    public String goDetail(Model model, int idx) {
        model.addAttribute("classInfo", fclassService.findByIdx(idx));
        model.addAttribute("branchList", branchService.findAll());
        return "fclass/b_detail";
    }

    @GetMapping("admin/fclass/branch")
    public String goBranch(Model model) {
        List<BranchVo> list = branchService.findAll();
        model.addAttribute("list", list);
        return "fclass/b_branch";
    }

    @GetMapping("admin/fclass/selectClass")
    public String goSelectClass() {
        return "fclass/b_selectClass";
    }

    @GetMapping("admin/fclass/manageSchedule")
    public String goManageSchedule(Integer classIdx, Integer branchIdx, Model model) {
        FclassVo fclassVo = fclassService.findByIdx(classIdx);
        BranchVo branchVo = branchService.findByIdx(branchIdx);

        model.addAttribute("fclass", fclassVo);
        model.addAttribute("branch", branchVo);

        return "fclass/b_manageSchedule";
    }

    @GetMapping("/admin/fclass/api/orders")
    public String getOrders(Model model, OclassSearchOptionDto searchOption) {
        List<OclassVo> orders = oclassService.findBySearchOption(searchOption);
        model.addAttribute("orders", orders);
        return "fclass/b_orderListContent";
    }

    @GetMapping("/admin/fclass/api/orders/{idx}")
    public String getOrder(Model model, @PathVariable Integer idx) {
        OclassVo oclass = oclassService.findByIdx(idx);
        model.addAttribute("order", oclass);
        return "fclass/b_orderListContentRow";
    }

    @RequestMapping(value = "/admin/fclass/api/orders/{idx}", method = RequestMethod.PUT)
    @ResponseBody
    public OclassVo updateOrderStatus(@RequestBody String status, @PathVariable Integer idx) {
        OclassVo oclassVo = OclassVo.builder()
                .status(status)
                .idx(idx)
                .build();
        return oclassService.updateOrderStatus(oclassVo);
    }

    @RequestMapping(value = "/admin/fclass/api/orders/{idx}", method = RequestMethod.DELETE)
    @ResponseBody
    public boolean deleteOrder(@PathVariable Integer idx) {
        /*oclassService.deleteOrder(idx);*/
        return oclassService.deleteOrder(idx);
    }

    @GetMapping("admin/fclass/api/findClassByCategory")
    @ResponseBody
    public List<FclassVo> findClassByCategory(String category) {
        return fclassService.findClassByCategory(category);
    }

    @GetMapping("admin/fclass/api/findBranchByClassIdx")
    @ResponseBody
    public List<BranchVo> findBranchByClassIdx(Integer classIdx) {
        return branchService.findBranchByClassIdx(classIdx);
    }

    @PostMapping("admin/fclass/api/addBranch")
    @ResponseBody
    public BranchVo addBranch(BranchVo vo, MultipartFile file) throws IOException {
        vo.setMapImage(fileHandler.uploadFile(file, null, "fclass/branch"));
        branchService.addBranch(vo);
        return vo;
    }
    @PostMapping("admin/fclass/api/deleteBranch")
    @ResponseBody
    public boolean deleteBranch(int idx) {
        branchService.deleteBranch(idx);
        return true;
    }
    @PostMapping("admin/fclass/api/updateBranch")
    @ResponseBody
    public BranchVo updateBranch(BranchVo vo, MultipartFile file) throws IOException {
        vo.setMapImage(fileHandler.uploadFile(file, vo.getMapImage(), "fclass/branch"));
        branchService.updateBranch(vo);
        return vo;
    }

    @PostMapping("/admin/fclass/api/addSchedule")
    @ResponseBody   // @ResponseBody -> java타입을 json문자열로 변환해서 반환한다 !
    public ScheduleVo addSchedule(@RequestBody ScheduleVo scheduleVo, Model model) { //@RequestBody -> json문자열로 들어오는거를 java객체로 변환해서 받는다 !
        model.addAttribute("schedule", scheduleVo);
        return scheduleService.addSchedule(scheduleVo);
    }

    @PostMapping("/admin/fclass/api/deleteScheduleByIdx")
    @ResponseBody
    public boolean deleteSchedule(@RequestBody List<Integer> idx) {
        return scheduleService.deleteSchedule(idx);
    }

    @PostMapping("/admin/fclass/api/updateSchedule")
    @ResponseBody
    public ScheduleVo updateSchedule(ScheduleVo vo) {
        return scheduleService.updateSchedule(vo);
    }
}
