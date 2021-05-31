package com.flo.alwaysbom.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FileHandler {
    String uploadFile(MultipartFile file, String dbName, String uploadFolder) throws IOException;
    boolean deleteFile(String path) throws IOException;
}
