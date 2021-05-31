package com.flo.alwaysbom.product.controller;

import com.flo.alwaysbom.product.service.ProductService;
import com.flo.alwaysbom.product.vo.ProductVo;
import com.flo.alwaysbom.util.FileHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class BackProductController {

    private final ProductService productService;
    private final FileHandler fileHandler;

    /* 소품샵 관리 인덱스 */
    @GetMapping("/admin/product")
    public String getIndex() {
        return "product/b_productManager";
    }

    /* 소품샵 상품리스트 조회 */
    @GetMapping("/admin/productList")
    public String getList(Model model) {
        getProductList(model, productService.findAll(), productService.findByCategory("vase"),
                productService.findByCategory("goods"));
        return "product/b_productList";
    }

    /* FrontOffice 상품리스트 조회와 로직이 중복되어 메소드로 뺌 */
    static void getProductList(Model model, List<ProductVo> all, List<ProductVo> vase, List<ProductVo> goods) {
        List<ProductVo> findAllList = all;
        List<ProductVo> findVaseList = vase;
        List<ProductVo> findGoodsList = goods;
        model.addAttribute("all", findAllList);
        model.addAttribute("vase", findVaseList);
        model.addAttribute("goods", findGoodsList);
    }

    /* 상품 등록페이지로 이동 */
    @GetMapping("/admin/productAddForm")
    public String goInsert() {
        return "product/b_addForm";
    }

    /* '등록하기' 버튼 눌렀을 때 처리 */
    @PostMapping("/admin/addProduct")
    public String addProduct(ProductVo vo, List<MultipartFile> file) throws IOException {
        vo.setImage1(fileHandler.uploadFile(file.get(0), null, "product"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), null, "product"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), null, "product"));
        System.out.println("productVo = " + vo);
        vo = productService.addProduct(vo);
        return "redirect:/admin/productList";
    }

    /* 상품 수정페이지로 이동 */
    @GetMapping("/admin/productUpdateForm/{idx}")
    public String goUpdate(@PathVariable Integer idx, Model model) {
        ProductVo product = productService.findByIdx(idx)
                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
        model.addAttribute("productVo", product);
        return "product/b_addForm";
    }

    /* '수정완료' 버튼 눌렀을 때 처리 */
    @PostMapping("/admin/updateProduct")
    public String updateProduct(ProductVo vo, List<MultipartFile> file) throws IOException {
        vo.setImage1(fileHandler.uploadFile(file.get(0), vo.getImage1(), "product"));
        vo.setImage2(fileHandler.uploadFile(file.get(1), vo.getImage2(), "product"));
        vo.setImage3(fileHandler.uploadFile(file.get(2), vo.getImage3(), "product"));
        System.out.println("productVo = " + vo);
        Integer idx = productService.updateProduct(vo);
        return "redirect:/admin/productList";
    }

    /* 상품 삭제 */
    @GetMapping("/admin/deleteProduct")
    public String deleteProduct(Integer idx) {
//        ProductVo product = backProductService.findByIdx(idx)
//                .orElseThrow(() -> new IllegalStateException("해당 상품 인덱스가 존재하지 않습니다"));
//        try {
//            fileHandler.deleteFile(product.getImage1());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        try {
//            fileHandler.deleteFile(product.getImage2());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        try {
//            fileHandler.deleteFile(product.getImage3());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
        productService.deleteProduct(idx);
        return "redirect:/admin/productList";
    }
}
