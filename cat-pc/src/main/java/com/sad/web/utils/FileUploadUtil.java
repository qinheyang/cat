package com.sad.web.utils;

import com.sad.web.constant.SystemConstant;
import org.apache.commons.io.FilenameUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

//TODO
public class FileUploadUtil {
    private static final String defaultPath = SystemConstant.PROFILE_PATH;
    public static final String upload(MultipartFile file) throws IOException {
        return  upload(file,defaultPath,null);
    }
    public static final String upload(MultipartFile file, String baseDir, String[] allowedExtension) throws IOException {
        String extension = FilenameUtils.getExtension(file.getOriginalFilename());
        String newFileName = UUIDUtil.generateUUID() +"."+extension;
        File newFile = new File(baseDir + File.separator + newFileName);
        if (!newFile.exists()) {
            if (!newFile.getParentFile().exists()) {
                newFile.getParentFile().mkdirs();
            }
        }
        file.transferTo(newFile);
        return getPathFileName(baseDir, newFileName);

    }

    public static final String getPathFileName(String uploadDir, String fileName) throws IOException {
        int dirLastIndex = defaultPath.length();
        String currentDir = uploadDir.length()>defaultPath.length()? uploadDir.substring(dirLastIndex)+"/":"";
        return SystemConstant.RESOURCE_PREFIX + "/" + currentDir+ fileName;
    }
}
