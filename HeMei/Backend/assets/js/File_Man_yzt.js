
var nv1 = new Vue({
    el: '#box',
    data: {
        totalCount: 200,//总项目数
        pageCount: 20, //分页数
        curPage: 1,//当前页面
        pagesize: 10,//分页大小
        showPages: 11, //显示分页按钮数
        showPagesStart: 1,//开始显示的分页按钮
        showPageEnd: 100,//结束显示的分页按钮

        batch: false,//是否显示多选框
        datas: [],//总的数据arrayData
        items: [],//显示的数据
       
        catitems: [],
        catfold: '-1',
        subitems: [],
        subfold:'-1',

        chosedata: [],//选中的

    },
    created: function () {
        //加载数据items
        var a = "";
        $.ajax({
            type: "get",
            url: "File_Man_WebService.asmx/InitFileMan",
            async: false,  //同步，既做完才往下
            success: function (str) { a = $(str).find("string").text(); }
        });
        var json = eval('(' + a + ')');
        for (var i in json) {
            if (json[i].CDT) json[i].CDT = formatDate(new Date(parseInt(json[i].CDT.slice(6, 19))));//转换DateTime LDT的格式
        }
        this.datas = json;
        this.items = json;
        var jlengtjh = 0;
        for (var i in json) { jlengtjh++; }
        this.totalCount = jlengtjh//总项目数
        this.pageCount = parseInt(this.totalCount / this.pagesize) + 1; //分页数

        //加载CATfolder
        $.ajax({
            type: "get",
            url: "File_Man_WebService.asmx/InitCat",
            success: function (str) {
                var c = $(str).find("string").text();
                nv1.catitems = eval('(' + c + ')');
            }
        });
       
    },
    methods: {
        showPage: function (pageIndex, $event, forceRefresh) {

            if (pageIndex > 0) {


                if (pageIndex > this.pageCount) {
                    pageIndex = this.pageCount;
                }

                //判断数据是否需要更新
                var currentPageCount = Math.ceil(this.totalCount / this.pagesize);
                if (currentPageCount != this.pageCount) {
                    pageIndex = 1;
                    this.pageCount = currentPageCount;
                }
                else if (this.curPage == pageIndex && currentPageCount == this.pageCount && typeof (forceRefresh) == "undefined") {
                    console.log("not refresh");
                    return;
                }

                this.curPage = pageIndex;
                //测试数据 随机生成的
                var newPageInfo = [];
                for (var i = 0; i < this.pagesize; i++) {
                    var j = (this.curPage - 1) * this.pagesize + i;
                    if (this.datas[j]) {
                        newPageInfo.push(this.datas[j]);
                    }
                }
                this.items = newPageInfo;

                //计算分页按钮数据
                if (this.pageCount > this.showPages) {
                    if (pageIndex <= (this.showPages - 1) / 2) {
                        this.showPagesStart = 1;
                        this.showPageEnd = this.showPages - 1;
                        console.log("showPage1")
                    }
                    else if (pageIndex >= this.pageCount - (this.showPages - 3) / 2) {
                        this.showPagesStart = this.pageCount - this.showPages + 2;
                        this.showPageEnd = this.pageCount;
                        console.log("showPage2")
                    }
                    else {
                        console.log("showPage3")
                        this.showPagesStart = pageIndex - (this.showPages - 3) / 2;
                        this.showPageEnd = pageIndex + (this.showPages - 3) / 2;
                    }
                }
                console.log("showPagesStart:" + this.showPagesStart + ",showPageEnd:" + this.showPageEnd + ",pageIndex:" + pageIndex);
            }
            //处理分页点中样式
            setTimeout(function () {
                var buttons = $("#pager").find("span");
                for (var i = 0; i < buttons.length; i++) {
                    if (buttons.eq(i).html() != pageIndex) {
                        buttons.eq(i).removeClass("active");
                    }
                    else {
                        buttons.eq(i).addClass("active");
                    }
                }
            }, 100);
        },
    },
    watch: {
        catfold: function () {
            //加载CATfolder
            $.ajax({
                type: "get",
                url: "File_Man_WebService.asmx/InitSub",
                data: { "catid": nv1.catfold },
                async: false,  //同步，既做完才往下
                success: function (str) {
                    var c = $(str).find("string").text();
                    nv1.subitems = eval('(' + c + ')');
                    nv1.subfold = '-1';
                }
            });
            if (nv1.catfold == '-1') {
                nv1.items = nv1.datas;
                var jlengtjh = 0;
                for (var i in a) { jlengtjh++; }
                nv1.totalCount = jlengtjh//总项目数
                nv1.pageCount = parseInt((nv1.totalCount - 1) / nv1.pagesize) + 1; //分页数
                var newPageInfo = [];
                for (var i = 0; i < nv1.pagesize; i++) {
                    var j = (nv1.curPage - 1) * nv1.pagesize + i;
                    if (nv1.items[j]) {
                        newPageInfo.push(nv1.items[j]);
                    }
                }
                nv1.items = newPageInfo;
            } else {
                
                if (nv1.subfold == '-1') {
                    var newarry = [];
                    for (var d in nv1.datas) {
                        if (nv1.datas[d].FolderID == nv1.catfold) newarry.push(nv1.datas[d]);
                    }
                    nv1.items = newarry;

                    var jlengtjh = 0;
                    for (var i in a) { jlengtjh++; }
                    nv1.totalCount = jlengtjh//总项目数
                    nv1.pageCount = parseInt((nv1.totalCount - 1) / nv1.pagesize) + 1; //分页数
                    var newPageInfo = [];
                    for (var i = 0; i < nv1.pagesize; i++) {
                        var j = (nv1.curPage - 1) * nv1.pagesize + i;
                        if (nv1.items[j]) {
                            newPageInfo.push(nv1.items[j]);
                        }
                    }
                    nv1.items = newPageInfo;
                }
            }
        },
        subfold: function () {
            if (nv1.subfold != "-1") {
                var newarry = [];
                for (var d in nv1.datas) {
                    if (nv1.datas[d].FolderID == nv1.subfold) newarry.push(nv1.datas[d]);
                }
                nv1.items = newarry;
                var jlengtjh = 0;
                for (var i in a) { jlengtjh++; }
                nv1.totalCount = jlengtjh//总项目数
                nv1.pageCount = parseInt((nv1.totalCount - 1) / nv1.pagesize) + 1; //分页数
                var newPageInfo = [];
                for (var i = 0; i < nv1.pagesize; i++) {
                    var j = (nv1.curPage - 1) * nv1.pagesize + i;
                    if (nv1.items[j]) {
                        newPageInfo.push(nv1.items[j]);
                    }
                }
                nv1.items = newPageInfo;
            } else {  }
        }


    }
});


function formatDate(dt) {
    var year = dt.getFullYear();
    var month = dt.getMonth() + 1;
    var date = dt.getDate();
    var hour = dt.getHours();
    var minute = dt.getMinutes();
    var second = dt.getSeconds();
    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
}
nv1.showPage(nv1.curPage, null, true);


$('#Checkbox1').click(function () {
    var ch = false;
    if ($('#Checkbox1').prop('checked')) ch = true;
    $("#tb input[type=checkbox]").each(function () {
        if (ch) $(this).prop("checked", true);
        else { $(this).prop("checked", false); }
    })
});
function operation(obj) {
    $("#tb input[type=checkbox]").each(function () {
        $(this).attr("checked", false);
    })
    $(obj).parent().parent().find("input[type=checkbox]").prop("checked", true);
}