package com.sad.web.controller.common;

import com.sad.web.config.SeverConfig;
import com.sad.web.entity.ResponseResult;
import com.sad.web.utils.FileUploadUtil;

import com.sad.web.utils.FileUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
//TODO
@RestController
@RequestMapping("/common")

public class CommonController {
    @Resource
    public SeverConfig serverConfig;
    @PostMapping("/upload")
    public ResponseResult uploadFile( MultipartFile file){
        String fileName = null;
        try {
            fileName = FileUploadUtil.upload(file);
            ResponseResult result = ResponseResult.success("上传成功");
            String url = serverConfig.getUrl() + fileName;
            result.put("url", url);
            result.put("fileName", fileName);
            result.put("newFileName", FileUtil.getName(fileName));
            result.put("originalFilename", file.getOriginalFilename());
            return result;
        } catch (Exception e) {

            return ResponseResult.error(e.getMessage());
        }

    }
}
