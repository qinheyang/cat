package com.sad.web.controller.system;


import com.sad.web.controller.BaseController;
import com.sad.web.entity.ResponseResult;
import com.sad.web.entity.system.SysMenu;
import com.sad.web.entity.system.SysRole;
import com.sad.web.entity.system.SysUser;
import com.sad.web.security.SecurityUtil;
import com.sad.web.service.system.ISysMenuService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.xml.bind.annotation.W3CDomHandler;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author Qinhy
 * @since 2023-09-16 09:22:05
 */
@RestController
@RequestMapping("/system/menu")
public class SysMenuController extends BaseController {
    @Resource
    private ISysMenuService sysMenuService;
    @GetMapping("/list")
    public ResponseResult list(SysMenu menu) {
        return ResponseResult.success(sysMenuService.list(menu));
    }
    @PostMapping("/add")
    public ResponseResult add(@RequestBody(required = false) SysMenu menu) {
        menu.setCreateBy(getCurrentLoginUserName());
        return ResponseResult.success(sysMenuService.insert(menu));
    }

    @PutMapping("/update")
    public ResponseResult update(@RequestBody(required = false) SysMenu menu) {
        return ResponseResult.success(sysMenuService.update(menu));
    }

    @GetMapping( "/{menuId}")
    public ResponseResult getInfo(@PathVariable(value = "menuId",required = false) Long menuId) {
        return ResponseResult.success(sysMenuService.getById(menuId));
    }

    @DeleteMapping("/delete/{menuIds}")
    public ResponseResult delete(@PathVariable(value = "menuIds",required = false) Long [] menuIds) {
        return ResponseResult.success(sysMenuService.deleteByIds(menuIds));
    }
    @GetMapping( "/treeselect")
    public ResponseResult treeSelect(){
        return ResponseResult.success(sysMenuService.getMenuTreeByUserId(getCurrentUserId()));
    }
    @GetMapping("/rolemenu/{roleId}")
    public ResponseResult getRoleMenu(@RequestParam(value = "roleId",required = false)Long roleId){
        return ResponseResult.success(sysMenuService.getMenuListByRoId(roleId));
    }

}
