package com.flo.alwaysbom.util;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequiredArgsConstructor
public class EditorController {

    private final FileHandler fileHandler;
    private final ServletContext context;


    @PostMapping("/uploadContent")
    @ResponseBody
    public Map<String, Object> uploadAndReturnLink(MultipartFile upload) throws IOException {

        String filePath = fileHandler.uploadFile(upload, null, "editor");

        HashMap<String, Object> result = new HashMap<>();
        result.put("url", filePath);
        result.put("result", true);
        return result;
    }
}
