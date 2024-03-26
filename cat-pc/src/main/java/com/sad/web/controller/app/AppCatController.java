package com.sad.web.controller.app;

import com.sad.web.config.SeverConfig;
import com.sad.web.entity.Cat;
import com.sad.web.entity.ResponseResult;
import com.sad.web.service.ICatService;
import com.sad.web.utils.FileUploadUtil;
import com.sad.web.utils.FileUtil;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

@RequestMapping("/app/cat")
@RestController
public class AppCatController {
    @Resource
    private ICatService catService;
    @Resource
    public SeverConfig serverConfig;

    @GetMapping("/list")
    public ResponseResult list(Cat cat) {
        return ResponseResult.success(catService.list(cat));
    }

    @GetMapping("/cat-name")
    public  ResponseResult getDetailByCatName(String catName){
        return ResponseResult.success(catService.getDetailByCatName(catName));
    }

    @PostMapping("/upload")
    public  ResponseResult upload(MultipartFile file, String catId,String userName){
        String fileName = null;
        try {
            fileName = FileUploadUtil.upload(file);
            ResponseResult result = ResponseResult.success("上传成功");
            String url = serverConfig.getUrl() + fileName;
            result.put("url", url);
            result.put("fileName", fileName);
            result.put("newFileName", FileUtil.getName(fileName));
            result.put("originalFilename", file.getOriginalFilename());
            Cat cat =new Cat();
            cat.setAvatar(fileName);
            cat.setPicture(fileName);
            cat.setUpdateBy(userName);
            cat.setCatId(Long.parseLong(catId));
            int count = catService.update(cat);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error(e.getMessage());
        }
    }
}
