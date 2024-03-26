<template>
  <div v-loading="loading">
    <el-form
      :inline="true"
      ref="selectForm"
      :model="params"
      label-width="60px"
      class="list-form"
    >
      <el-form-item prop="catName" label="猫咪名称">
        <el-input placeholder="请输入猫咪名称" v-model="params.catName">
        </el-input>
      </el-form-item>
          
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" @click="searchList"
          >搜索</el-button
        >
        <el-button icon="el-icon-refresh" @click="refresh('selectForm')"
          >重置</el-button
        >
      </el-form-item>
      <div class="list-btn-box">
        <el-button
          plain
          type="primary"
          icon="el-icon-plus"
          @click="showDialogForm(undefined)"
          >新增</el-button
        >
        <el-button
          plain
          type="danger"
          icon="el-icon-delete"
          :disabled="deleteDisable"
          @click="deleteByIds()"
          >批量删除</el-button
        >
        <!-- <el-button plain type="info" icon="el-icon-upload2" @click="searchList"
          >导入</el-button
        >
        <el-button
          plain
          type="warning"
          icon="el-icon-download"
          @click="refresh('selectForm')"
          >导出</el-button
        > -->
      </div>
    </el-form>
    <el-table
      :data="tableData"
      stripe
      @selection-change="handleSelectionChange"
      height="490px"
    >
      <el-table-column align="center" type="selection" fixed></el-table-column>
      <el-table-column
        type="index"
        align="center"
        label="猫咪编号"
        width="100"
      ></el-table-column>
      <el-table-column align="center" prop="catName" label="猫咪名">
      </el-table-column>
      <el-table-column align="center" prop="state" label="状况">
          <template slot-scope="scope">
          {{stateMap[scope.row.state] }}
        </template>
      </el-table-column>
      <el-table-column align="center" prop="color" label="毛色">
      </el-table-column>
      <el-table-column align="center"  label="性别">
         <template slot-scope="scope">
          {{sexMap[scope.row.sex] }}
        </template>
      </el-table-column>
      <el-table-column align="center"  label="绝育状况">
        <template slot-scope="scope">
          {{ scope.row.isSterile?'已绝育':'未绝育' }}
        </template>
      </el-table-column>
      <el-table-column
        align="center"
        prop="sterileTime"
        label="绝育时间"
        :formatter="formatDate"
      >
      </el-table-column>
      <el-table-column align="center" prop="firstWitness" label="第一次目击">
      </el-table-column>
      <el-table-column
        align="center"
        prop="createTime"
        label="创建时间"
        :formatter="formatTime"
      >
      </el-table-column>
      <el-table-column align="center" label="操作">
        <template slot-scope="scope">
          <el-button
            type="text"
            icon="el-icon-edit"
            @click="handleEdit(scope.$index, scope.row)"
            >修改</el-button
          >
          <el-button
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      background
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="params.pageNum"
      :page-sizes="[10, 20, 30, 40]"
      :page-size="params.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
    >
    </el-pagination>
    <catSave ref="catSave" @refresh-list="refreshList"></catSave>
  </div>
</template>
<script>
import { listCat, deleteCat } from "@/api/cat-manage/cat";

import catSave from "./cat-save";
import { formatTime,formatDate } from "@/utils/elementui-util";
export default {
  components: {
    catSave,
  },
  data() {
    return {
      tableData: null,
      total: null,
      loading: true,
      params: {
        pageNum: 1,
        pageSize: 10,
        catName: null,
      },
      catIds: [],
      deleteDisable: true,
      stateMap:{
        "0":"健康",
        "1":"送养",
        "2":"失踪",
        "3":"离世"
      },
      sexMap:{
        "0":"公",
        "1":"母",
        "2":"未知"
      }
    };
  },
  created() {
    this.searchList();
  },
  methods: {
    formatTime,
    formatDate,
    handleSizeChange(val) {
      this.params.pageSize = val;
      this.searchList();
    },
    handleCurrentChange(val) {
      this.params.pageNum = val;
      this.searchList();
    },
    searchList() {
      this.loading = true;
      listCat(this.params).then((resp) => {
        this.tableData = resp.data.records;
        this.total = resp.data.total;
        this.$globeValue.loadingDelay(this);
      });
    },
    refresh(formName) {
      this.$refs[formName].resetFields();
    },
    showDialogForm(catId) {
      this.$refs.catSave.openDialog(catId);
    },
    refreshList(catId) {
      if (catId === undefined) {
        this.params.pageNum = 1;
      }
      this.searchList();
    },
    handleEdit(index, row) {
      this.showDialogForm(row.catId);
    },
    handleDelete(index, row) {
      this.$confirm("此操作将永久删除, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          deleteCat(row.catId).then(() => {
            this.$message.success("删除成功");
            this.searchList();
          });
        })
        .catch(() => {});
    },
    deleteByIds() {
      this.$confirm("此操作将永久删除, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          deleteCat(this.catIds).then(() => {
            this.$message.success("删除成功");
            this.searchList();
          });
        })
        .catch(() => {});
    },
    handleSelectionChange(val) {
      this.catIds = val.map((item) => item.catId);
      if (val.length != 0) {
        this.deleteDisable = false;
      } else {
        this.deleteDisable = true;
      }
    },
  },
};
</script>
