 <template>
  <div class="header-box">
    <span style="flex:0 0 5%; text-align: left"
          class="collapse-icon">
      <i :class="collapseIcon"
         @click="hadleCollapse"></i> </span>

    <el-breadcrumb separator="/"
                   style="flex: 0 0 89%; text-align: right;">

      <el-breadcrumb-item v-for="(item, index) in breadcrumbList"
                          :key="index">
        <span v-if="index!==0||breadcrumbList.length===1">{{ item.meta.title }}</span>
        <a v-else
           :href="item.path">{{ item.meta.title}}</a>

      </el-breadcrumb-item>
    </el-breadcrumb>

    <!-- <span style="flex: 0 0 auto; text-align: right">王小虎 <i class="el-icon-arrow-down"></i></span> -->
  </div>
</template>
<style lang="scss">
.header-box {
  width: 100%;
  height: 100%;
  border-bottom: 1px solid #bec2c9;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
}
</style>
<script>
export default {
  data () {
    return {
      isCollapse: false,
      collapseIcon: "el-icon-s-fold",
      breadcrumbList: null,

    };
  },
  created () {
    this.getBreadcrumbList();

  },
  computed: {

  },
  watch: {
    isCollapse (n) {
      n ? this.collapseIcon = "el-icon-s-unfold" : this.collapseIcon = "el-icon-s-fold";
    },
    $route () {
      // if (route.path.startsWith('/redirect/')) {
      //   return
      // }
      this.getBreadcrumbList()
    }

  },
  methods: {
    hadleCollapse () {
      this.isCollapse = !this.isCollapse;
      this.$emit('change-collapse');

    },
    getBreadcrumbList () {
      let matched = this.$route.matched.filter(item => item.meta && item.meta.title);
      const first = matched[0]

      if (!this.isHome(first)) {
        matched = [{ path: '/', meta: { title: '首页' } }].concat(matched)
      }

      this.breadcrumbList = matched.filter(item => item.meta && item.meta.title && item.meta.breadcrumb !== false)
    },
    isHome (route) {
      const name = route && route.name
      if (!name) {
        return false;
      }
      return name.trim() === 'home';
    },
  },
}
</script>
