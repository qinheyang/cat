package com.sad.web.controller.app;

import com.sad.web.config.SeverConfig;
import com.sad.web.entity.Cat;
import com.sad.web.entity.ResponseResult;
import com.sad.web.entity.system.SysUser;
import com.sad.web.service.system.ISysUserService;
import com.sad.web.utils.FileUploadUtil;
import com.sad.web.utils.FileUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

@RequestMapping("/app/user")
@RestController
public class AppUserController {

    @Resource
    public SeverConfig serverConfig;
    @Resource
    private ISysUserService userService;
    @PostMapping("/verify")
    public ResponseResult verifyUser(String userName,String password){
        return ResponseResult.success(userService.verifyUser(userName,password));
    }

    @PostMapping("/save")
    public ResponseResult save(String key,String value,String userName,Long userId){
        return ResponseResult.success(userService.save(key,value,userName,userId));
    }


    @PostMapping("/upload")
    public  ResponseResult upload(MultipartFile file, String userId, String userName){
        String fileName = null;
        try {
            fileName = FileUploadUtil.upload(file);
            ResponseResult result = ResponseResult.success("上传成功");
            String url = serverConfig.getUrl() + fileName;
            result.put("url", url);
            result.put("fileName", fileName);
            result.put("newFileName", FileUtil.getName(fileName));
            result.put("originalFilename", file.getOriginalFilename());
            int count = userService.save("avatar",fileName,userName,Long.parseLong(userId));
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.error(e.getMessage());
        }
    }

}
