package com.sad.web.controller;


import com.sad.web.entity.Cat;
import com.sad.web.entity.ResponseResult;
import com.sad.web.entity.system.SysMenu;
import com.sad.web.entity.system.SysRole;
import com.sad.web.service.ICatService;
import com.sad.web.service.system.ISysMenuService;
import com.sad.web.service.system.ISysRoleService;
import org.springframework.web.bind.annotation.*;

import com.sad.web.controller.BaseController;

import javax.annotation.Resource;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author Qinhy
 * @since 2023-10-11 10:03:05
 */
@RestController
@RequestMapping("/cat-manage/cat")
public class CatController extends BaseController {



    @Resource
    private ICatService catService;


    @GetMapping("/list")
    public ResponseResult list(Cat cat, @RequestParam(value = "pageNum") Integer pageNum, @RequestParam(value = "pageSize") Integer pageSize) {
        return ResponseResult.success(catService.list(cat, pageNum, pageSize));
    }

    @PostMapping("/add")
    public ResponseResult add(@RequestBody(required = false) Cat cat) {
        return ResponseResult.success(catService.add(cat));
    }

    @PutMapping("/update")
    public ResponseResult update(@RequestBody(required = false) Cat cat) {
        return ResponseResult.success(catService.update(cat));
    }

    @GetMapping("/{catId}")
    public ResponseResult getInfo(@PathVariable(value = "catId", required = false) Long catId) {
        return ResponseResult.success(catService.getById(catId));
    }

    @DeleteMapping("/delete/{catIds}")
    public ResponseResult delete(@PathVariable(value = "catIds", required = false) Long[] catIds) {
        return ResponseResult.success(catService.deleteByIds(catIds));
    }

}
