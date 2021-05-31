package com.flo.alwaysbom.util;

import lombok.RequiredArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.regex.Matcher;

@RequiredArgsConstructor
public class LocalFileHandler implements FileHandler {

    private final ServletContext context;

    public String uploadFile(MultipartFile file, String dbName, String uploadFolder) throws IOException {
        if (!file.isEmpty()) {
            String oriName = file.getOriginalFilename();
            int dotIndex = oriName.lastIndexOf("."); //adf..sf.d.sdafdfd.jpg
            if (dotIndex >= 0 && dotIndex < oriName.length() - 1) {
                String ext = oriName.substring(dotIndex);
                String fileName = UUID.randomUUID().toString() + ext;

                File folder = new File("static/upload", uploadFolder);
                String folderPath = context.getRealPath(folder.getPath());

                //폴더가 있는지 체크
                File f = new File(folderPath);
                if (!f.exists()) {
                    f.mkdirs();
                }

                File realFile = new File(folderPath, fileName);
                file.transferTo(realFile);

                //기존 파일이 있다면 지우겠다
                if (dbName != null) {
                    if (deleteFile(dbName)) {
                        System.out.println(dbName + "\n기존 파일을 삭제하였습니다");
                    } else {
                        System.out.println(dbName + "\n기존 파일 삭제 실패했습니다");
                    }
                }

                String finalPath = "/" + new File(new File("/static/upload/", uploadFolder), fileName).getPath().substring(1);
                return finalPath.replaceAll(Matcher.quoteReplacement(File.separator), "/");
            } else {
                System.out.println(".이 없거나 확장자의 길이가 1보다 작습니다");
                return null;
            }
        } else {
            return dbName;
        }
    }

    @Override
    public boolean deleteFile(String path) {
        try {
            if (path != null) {
                String folderPath = context.getRealPath("");
                File realFile = new File(folderPath, path);
                return Files.deleteIfExists(realFile.toPath());
            } else {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
