<template>
  <el-aside width="auto">
    <el-menu :router="true"
             class="el-menu-vertical"
         
       
             active-text-color=""
             :collapse="isCollapse">
      <tree-menu :data="menuList"></tree-menu>
    </el-menu>
  </el-aside>
</template>
<script>
import treeMenu from "@/views/layout/components/tree-menu.vue";

export default {
  components: {
    treeMenu,
  },
  computed: {
    menuList () {
      var menus = []
      for (let item of this.$router.options.routes) {
        if (item.redirect) {
          menus.push(item.children[0])
        } else {
          menus.push(item)
        }
      }
      menus.push(...this.$store.state.dynamicRoutes);
      console.log(this.$store.state.dynamicRoutes)
      return menus;
    }
  },
  props: ['isCollapse'],
  data () {
    return {
    }
  }

}
</script>