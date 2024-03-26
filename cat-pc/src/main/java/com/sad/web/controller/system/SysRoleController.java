package com.sad.web.controller.system;


import com.sad.web.controller.BaseController;
import com.sad.web.entity.ResponseResult;
import com.sad.web.entity.system.SysMenu;
import com.sad.web.entity.system.SysRole;
import com.sad.web.entity.system.SysUser;
import com.sad.web.service.system.ISysMenuService;
import com.sad.web.service.system.ISysRoleService;
import com.sad.web.service.system.ISysUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Qinhy
 * @since 2023-09-11 08:47:03
 */
@RestController
@RequestMapping("/system/role")
public class SysRoleController extends BaseController {
    @Resource
    private ISysRoleService sysRoleService;

    @Resource
    private ISysMenuService sysMenuService;

    @GetMapping("/list")
    public ResponseResult list(SysRole role, @RequestParam(value = "pageNum") Integer pageNum, @RequestParam(value = "pageSize") Integer pageSize) {
        return ResponseResult.success(sysRoleService.list(role, pageNum, pageSize));
    }

    @PostMapping("/add")
    public ResponseResult add(@RequestBody(required = false) SysRole role) {
        return ResponseResult.success(sysRoleService.add(role));
    }

    @PutMapping("/update")
    public ResponseResult update(@RequestBody(required = false) SysRole role) {
        return ResponseResult.success(sysRoleService.update(role));
    }

    @GetMapping("/{roleId}")
    public ResponseResult getInfo(@PathVariable(value = "roleId", required = false) Long roleId) {
        SysRole role = sysRoleService.getById(roleId);
        role.setMenuIds(sysMenuService.getMenuListByRoId(roleId).stream().map(SysMenu::getMenuId).toArray(Long[]::new));
        return ResponseResult.success(role);
    }

    @DeleteMapping("/delete/{roleIds}")
    public ResponseResult delete(@PathVariable(value = "roleIds", required = false) Long[] roleIds) {
        return ResponseResult.success(sysRoleService.deleteByIds(roleIds));
    }

}
