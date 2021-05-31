package com.flo.alwaysbom.util;

import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.storage.*;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;

public class CloudFileHandler implements FileHandler {

    private final String BUCKET_NAME = "upload.alwaysbom.xyz";
    private final Storage storage;

    public CloudFileHandler() throws IOException {
        Resource resource = new DefaultResourceLoader().getResource("classpath:storage-credential.json");
        this.storage = StorageOptions.newBuilder()
                .setCredentials(ServiceAccountCredentials.fromStream(resource.getInputStream()))
                .build()
                .getService();
    }

    public String uploadFile(MultipartFile file, String dbName, String uploadFolder) throws IOException {
        if (file != null && !file.isEmpty()) {

            String oriName = file.getOriginalFilename();
            int dotIndex = oriName.lastIndexOf(".");
            if (dotIndex >= 0 && dotIndex < oriName.length() - 1) {
                String randomName = RandomStringUtils.randomAlphabetic(10) + "-" + oriName;
                String fileName = new File(new File("/", uploadFolder), randomName).getPath().substring(1)
                        .replaceAll(Matcher.quoteReplacement(File.separator), "/");

                if (dbName != null) {
                    deleteFile(dbName);
                }

                List<Acl> acls = new ArrayList<>();
                acls.add(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));
                Blob blob = storage.create(BlobInfo.newBuilder(BUCKET_NAME, fileName).setAcl(acls).build(), file.getBytes());

                return blob.getMediaLink();
            } else {
                System.out.println(".이 없거나 확장자의 길이가 1보다 작습니다");
                return null;
            }
        } else {
            return dbName;
        }
    }

    public boolean deleteFile(String path) {
        if (path != null) {
            try {
                String fileName = path.substring(path.lastIndexOf("/")+1, path.lastIndexOf("?")).replaceAll("%2F", "/");
                Blob blob = storage.get(BUCKET_NAME, fileName);
                if (blob != null) {
                    return blob.delete();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
