
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
        catselect: '-1',
        catmove: '',//用于移动中的选择
        submoveitems: [],//用于移动中的选择
        has1: false,//用于移动中的选择
        subitems: [],
        subselect: '-1',
        author: [],//用于显示作者
        usertag: [],//用于显示用户标签
        has: false,//判断是否显示sub

        chosedata: [],//选中的
        Limiters: [{ "LimitName": "作者", "Content": "" }, { "LimitName": "用户标签", "Content": "" }, { "LimitName": "起止时间", "Content": "" }]

    },
    created: function () {
        //加载数据items
        var a = "";
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/InitArticleMan",
            async: false,  //同步，既做完才往下
            success: function (str) { a = $(str).find("string").text(); }
        });
        var json = eval('(' + a + ')');
        for (var i in json) {
            if (json[i].LDT) json[i].LDT = formatDate(new Date(parseInt(json[i].LDT.slice(6, 19))));//转换DateTime LDT的格式
        }
        this.datas = json;
        this.items = json;
        var jlengtjh = 0;
        for (var i in json) { jlengtjh++; }
        this.totalCount = jlengtjh//总项目数
        this.pageCount = parseInt(this.totalCount / this.pagesize) + 1; //分页数

        //加载CAT和SUB
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/InitCat",
            success: function (str) {
                var c = $(str).find("string").text();
                nv1.catitems = eval('(' + c + ')');
            }
        });
        //加载Author
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/InitAuthor",
            success: function (str) {
                var a = $(str).find("string").text();
                nv1.author = eval('(' + a + ')');
            }
        });
        //加载UserTag
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/InitUserTag",
            success: function (str) {
                var a = $(str).find("string").text();
                nv1.usertag = eval('(' + a + ')');
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
        cancel: function (i) {
            var newarry = [];
            for (var d in nv1.chosedata) {
                if (nv1.chosedata[d].ID != i) newarry.push(nv1.chosedata[d]);
            }
            nv1.chosedata = newarry;
        },
        url: function (ID) {
            window.location.href = "Articles_Add.aspx?ID=" + ID;
        }
    },
    watch: {
        catselect: function () {
            if (nv1.catselect != "-1") {
                for (var i in nv1.catitems) {
                    if (nv1.catitems[i].ID == nv1.catselect) {
                        if (nv1.catitems[i].Subs == 0) nv1.has = false;
                        else {
                            nv1.has = true;
                            $.ajax({
                                type: "get",
                                url: "Articles_Rescyle_WebService.asmx/InitSub",
                                data: { "cat": nv1.catselect },
                                success: function (str) {
                                    var s = $(str).find("string").text();
                                    nv1.subitems = eval('(' + s + ')');
                                }
                            });
                        }
                        updateItem();
                    }
                }
            } else {
                nv1.has = false;
                nv1.subselect = "-1";
                nv1.subitems = [];
                updateItem();
            }
        },
        subselect: function () {
            if (nv1.catselect != "-1") {
                updateItem();
            } else {
                updateItem();
            }
        },
        catmove: function () {
            for (var i in nv1.catitems) {
                if (nv1.catitems[i].ID == nv1.catmove) {
                    if (nv1.catitems[i].Subs == 0) nv1.has1 = false;
                    else {
                        nv1.has1 = true;
                        $.ajax({
                            type: "get",
                            url: "Articles_Rescyle_WebService.asmx/InitSub",
                            data: { "cat": nv1.catmove },
                            success: function (str) {
                                var s = $(str).find("string").text();
                                nv1.submoveitems = eval('(' + s + ')');
                            }
                        });
                    }
                }
            }

        }

    }
});

function updateItem() {
    var author = $('#hid_author').val();
    var usertag = $('#hid_usertag').val();
    var starttime = $('#hid_starttime').val();
    var endtime = $('#hid_endtime').val();
    var a = [];
    $.ajax({
        type: "get",
        url: "Articles_Rescyle_WebService.asmx/UpdateArticleMan",
        async: false,  //同步，既做完才往下
        data: { "cat": nv1.catselect, "sub": nv1.subselect, "author": author, "usertag": usertag, "starttime": starttime, "endtime": endtime },
        success: function (str) {
            var data = $(str).find("string").text();
            a = eval('(' + data + ')');
        }
    });
    for (var i in a) {
        if (a[i].LDT) a[i].LDT = formatDate(new Date(parseInt(a[i].LDT.slice(6, 19))));//转换DateTime LDT的格式
    }
    nv1.datas = a;
    nv1.items = a;
    var jlengtjh = 0;
    for (var i in a) { jlengtjh++; }
    nv1.totalCount = jlengtjh//总项目数
    nv1.pageCount = parseInt((nv1.totalCount - 1) / nv1.pagesize) + 1; //分页数
    var newPageInfo = [];
    for (var i = 0; i < nv1.pagesize; i++) {
        var j = (nv1.curPage - 1) * nv1.pagesize + i;
        if (nv1.datas[j]) {
            newPageInfo.push(nv1.datas[j]);
        }
    }
    nv1.items = newPageInfo;
}


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


//用于选择筛选条件
function chose(obj) {
    if ($(obj).text() == "全部") {
        $(obj).parent().find("button").each(function () {
            $(this).removeClass('chose')
        });
    } else {
        $(obj).parent().find("button").each(function () {
            if ($(this).text() == '全部') $(this).removeClass('chose');
        });
    }
    $(obj).toggleClass('chose');
}

//清除筛选
function clear_search() {
    $('#search_usertag').find('button').each(function () {
        if ($(this).text() == '全部') { $(this).addClass("chose") }
        else { $(this).removeClass("chose") }
    })
    $('#search_author').find('button').each(function () {
        if ($(this).text() == '全部') { $(this).addClass("chose") }
        else { $(this).removeClass("chose") }
    })
    $('#hid_starttime').val("");
    $('#hid_endtime').val("");
    $('#starttime_chose').val("");
    $('#endtime_chose').val("");
    true_search();
}

//确搜索按钮
function true_search() {
    $('#hid_author').val("");
    $('#hid_usertag').val("");
    $('#search_author').find('button').each(function () {
        if ($(this).text() == '全部' && $(this).hasClass("chose")) { }
        else if ($(this).hasClass("chose")) {
            if ($('#hid_author').val() != "") { $('#hid_author').val($('#hid_author').val() + ",'" + $(this).text() + "'") }
            else { $('#hid_author').val("'" + $(this).text() + "'") }
        }
    });
    $('#search_usertag').find('button').each(function () {
        if ($(this).text() == '全部' && $(this).hasClass("chose")) { }
        else if ($(this).hasClass("chose")) {
            if ($('#hid_usertag').val() != "") { $('#hid_usertag').val($('#hid_usertag').val() + ",'" + $(this).text() + "'") }
            else { $('#hid_usertag').val("'" + $(this).text() + "'") }
        }
    });
    nv1.Limiters = [{ "LimitName": "作者", "Content": "" }, { "LimitName": "用户标签", "Content": "" }, { "LimitName": "起止时间", "Content": "" }];
    if ($('#hid_author').val() != "") nv1.Limiters[0].Content = $('#hid_author').val();
    if ($('#hid_usertag').val() != "") nv1.Limiters[1].Content = $('#hid_usertag').val();
    if ($('#hid_starttime').val() != "" && $('#hid_endtime').val() != "") nv1.Limiters[2].Content = $('#hid_starttime').val() + "至" + $('#hid_endtime').val();
    updateItem()
    $('#collapseexample').collapse('hide');
}




//操作显示时
var ids = "";
$('#layer').on('show.bs.modal', function (e) {
    ids = "";
    nv1.chosedata = [];
    $("#tb input[type=checkbox]").each(function () {
        if ($(this).val() != 0) {
            if ($(this).prop('checked')) {
                ids += "'" + $(this).val() + "',"
            }
        }
    });
    if (ids.lastIndexOf(",") == ids.length - 1) ids = ids.substring(0, ids.length - 1);
    if (ids != "") {
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/SelectArticle",
            async: false,  //同步，既做完才往下
            data: { "ids": ids },
            success: function (str) {
                var data = $(str).find("string").text();
                nv1.chosedata = eval('(' + data + ')');
            }
        });
    }

})
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
$('#morechose').click(function () {
    $('#morechose i').toggleClass("glyphicon-chevron-down");
    $('#morechose i').toggleClass("glyphicon-chevron-up");
    if ($('#morechose i').attr("class") == "glyphicon glyphicon-chevron-up") $('#morechose span').text("隐藏更多筛选")
    else { $('#morechose span').text("展开更多筛选") }
})
/*日期选择器的语言的Script*/
$('.form_date').datetimepicker({
    language: 'zh-CN',
    weekStart: 1,
    todayBtn: 1,
    autoclose: 1,
    todayHighlight: 1,
    startView: 2,
    minView: 2,
    forceParse: 0
});

function rescyleArticles() {
    var articleids = "";
    for (var i in nv1.chosedata) {
        if (nv1.chosedata[i]) articleids += nv1.chosedata[i].ID + ",";
    }
    if (articleids.lastIndexOf(",") == articleids.length - 1) articleids = articleids.substring(0, articleids.length - 1);
    if (articleids != "") {
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/RescyleArticle",
            data: { "ids": articleids },
            success: function (str) {
                alert("已成功恢复文章");
                window.location.reload();
            }
        });
    }
}
function topArticle() {
    var articleids = "";
    for (var i in nv1.chosedata) {
        if (nv1.chosedata[i]) articleids += nv1.chosedata[i].ID + ",";
    }
    if (articleids.lastIndexOf(",") == articleids.length - 1) articleids = articleids.substring(0, articleids.length - 1);
    if (articleids != "") {
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/TopArticle",
            data: { "ids": articleids },
            success: function (str) {
                alert("已成功置顶");
                window.location.reload();
            }
        });
    }
}
function deleteArticles() {
    var articleids = "";
    for (var i in nv1.chosedata) {
        if (nv1.chosedata[i]) articleids += nv1.chosedata[i].ID + ",";
    }
    if (articleids.lastIndexOf(",") == articleids.length - 1) articleids = articleids.substring(0, articleids.length - 1);
    if (articleids != "") {
        $.ajax({
            type: "get",
            url: "Articles_Rescyle_WebService.asmx/DeleteArticle",
            data: {
                "ids": articleids,
            },
            success: function (str) {
                alert("已成功粉碎文章");
                window.location.reload();
            }
        });
    }
}