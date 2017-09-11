//Vue.filter('date', function (input) {
//    var s = eval(input.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
//    var oDate = new Date(s);
//    return oDate.getFullYear() + '-' + (oDate.getMonth() + 1) + '-' + oDate.getDate() + ' ' + oDate.getHours() + ':' + oDate.getMinutes() + ':' + oDate.getSeconds();

//});

var nv1 = new Vue({
    el: '#box',
    data: {
        batch: false,//是否显示多选宽
        datas: [],//总的数据
        items: [],//显示的数据
        web_order: false,//用于之后排序false是大到小,下同
        cdt_order: false,
        ismainsite_order: false,
        datanums:'',
        pageSize: '',//翻页每页显示数据
        curPage: 0,//当前页面
        pageCount: '',//总共页面数
        onn: true,//默认显示分页
        pageShow: [],//分页按钮的data
        moreleft: false,
        moreright: true,
        time: false,
        nowIndex: -100,//表格不存在index
        searchlist: [],
        rowtemplate: { ID: 0, WebName: '', Description: '', IsMainSite: '', CDT: '' }
    },
    created: function () {//加载数据items
        var a = "";
        $.ajax({
            type: "get",
            url: "User_WebService.asmx/InitWebMan",
            async: false,  //同步，既做完才往下
            success: function (str) { a = $(str).find("string").text(); }
        });
        var json = eval('(' + a + ')');
        this.datas = json;
        this.items = json.slice(0, 5);
        this.setSlist(this.items);
        this.pageSize = 5;
        this.datanums = parseInt(Object.keys(this.datas).length);
        this.pageCount = Object.keys(this.datas).length / this.pageSize;
        if (this.pageCount < 4) {
            for (var i = 0; i < this.pageCount; i++) { this.pageShow.push(i + 1); }
            this.moreright = false;
        } else {
            for (var i = 0; i < 4; i++) { this.pageShow.push(i + 1); }
            this.moreright = true;
        }
     
    },
    methods: {

        order: function (sx, judge) {
            function down(a, b) {//按该字段倒序
                if (sx == "Web") { nv1.web_order = true; return (a.WebName + '').localeCompare(b.WebName + '') }
                if (sx == "CDT") { nv1.cdt_order = true; return (a.CDT + '').localeCompare(b.CDT + '') }
                if (sx == "IsMainSite") { nv1.ismainsite_order = true; return (a.IsMainSite + '').localeCompare(b.IsMainSite + '') }
            }
            function up(a, b) {//按该字段顺序
                if (sx == "Web") { nv1.web_order = false; return (b.WebName + '').localeCompare(a.WebName + '') }
                if (sx == "CDT") { nv1.cdt_order = false; return (b.CDT + '').localeCompare(a.CDT + '') }
                if (sx == "IsMainSite") { nv1.ismainsite_order = false; return (b.IsMainSite + '').localeCompare(a.IsMainSite + '') }
            }
            judge == false ? nv1.items.sort(down) : nv1.items.sort(up);
        },
        Edit: function (index) {
            this.time = true;
            $("#mainsite").val(Number(index.IsMainSite));   // 设置Select的Value值为Number(index.IsMainSite)的项选中
            this.rowtemplate = index;
            var str = "";
            if (Number(index.IsMainSite) == 0) {
                str = "False";
            }
            else
            {
                str = "True";
            }
            this.rowtemplate.IsMainSite = str;
        },
        Save: function (event) {
            var ismainsite;
            if (this.rowtemplate.IsMainSite == "True") {
                ismainsite = 1;//表示往数据库插入true
            } else {
                ismainsite = 0;//表示往数据库插入false
            }
            if (this.rowtemplate.ID == 0) { //表示新增网站
             
                if (this.rowtemplate.WebName != "") {
                    this.rowtemplate.CDT = formatDate(new Date());
                    this.items.push(this.rowtemplate);
                    $.ajax({
                        type: "post",
                        data: {
                            WebName: this.rowtemplate.WebName,
                            Description: this.rowtemplate.Description,
                            IsMainSite: ismainsite,
                        },
                        url: "User_WebService.asmx/InsertWeb",
                        async: false,  //同步，既做完才往下
                        success: function (str) { console.log(str); }
                    });
                   
                 
                }
                else
                {
                    alert("网站名不能为空");
                }
            }
            else//表示编辑网站
            {
              
                $.ajax({
                    type: "post",
                    data: {
                        ID: this.rowtemplate.ID,
                        WebName: this.rowtemplate.WebName,
                        Description: this.rowtemplate.Description,
                        IsMainSite: ismainsite
                    },
                    url: "User_WebService.asmx/EditWeb",
                    async: false,  //同步，既做完才往下
                    success: function (str) { console.log(str); }
                });
            }

            //还原模板
            this.rowtemplate = { ID: 0, WebName: '', Description: '', IsMainSite: '', CDT: '' }
        },
        Delete: function (id) {
            //实际项目中参数操作肯定会涉及到id去后台删除，这里只是展示，先这么处理。
            for (var i = 0; i < this.items.length; i++) {
                if (this.items[i].ID == id) {
                    this.items.splice(i, 1);
                    break;
                }
            }

            $.ajax({
                type: "post",
                data: {
                    ID: id,
                },
                url: "User_WebService.asmx/DelWeb",
                async: false,  //同步，既做完才往下
                success: function (str) { console.log(str); }
            });
        },

        // 获取需要渲染到页面中的数据
        setSlist(arr) {
            this.items = JSON.parse(JSON.stringify(arr));
        },
        // 搜索
        search(e) {
            var v = e.target.value,
                self = this;
            self.searchlist = [];
            if (v) {
                var ss = [];

                // 过滤需要的数据
                this.datas.forEach(function (item) {
                    if (item.WebName.indexOf(v) > -1) {
                        if (self.searchlist.indexOf(item.WebName) == -1) {
                            self.searchlist.push(item.WebName);
                        }
                        ss.push(item);
                    } else if (item.Description.indexOf(v) > -1) {
                        if (self.searchlist.indexOf(item.Description) == -1) {
                            self.searchlist.push(item.Description);
                        }
                        ss.push(item);
                    }
                });
                this.setSlist(ss); // 将过滤后的数据给了slist
            } else {
                // 没有搜索内容，则展示全部数据
                this.setSlist(this.datas);
            }
        },
        page: function (el) {//点击翻页                 
            el == 'last' ? this.curPage-- : this.curPage++;
            var curtotal = this.curPage * this.pageSize;
            var tiaoshu = this.curPage * this.pageSize + this.pageSize;
            this.items = this.datas.slice(curtotal, tiaoshu);
            var a = this.curPage;
        },
        page1: function (a) {
            if (a == 'right') {
                a = this.curPage = (this.curPage / this.pageSize + 1) * this.pageSize - 1;
                for (var i in nv1.pageShow) {
                    nv1.pageShow[i] += nv1.pageSize - 1;
                    if (nv1.pageShow[i] > nv1.pageCount) this.moreright = false;
                }
                this.moreleft = true;
            }
            if (a == 'left') {
                a = this.curPage = (this.curPage / this.pageSize - 1) * this.pageSize + 1;
                for (var i in nv1.pageShow) {
                    nv1.pageShow[i] -= nv1.pageSize - 1;
                }
                if (nv1.pageShow[0] == 1) this.moreleft = false;
                this.moreright = true;
            }
            this.curPage = a;
            var curtotal = a * this.pageSize;
            var tiaoshu = a * this.pageSize + this.pageSize;
            this.items = this.datas.slice(curtotal, tiaoshu);
        },
        fanye: function () {//分页处理
            var _this = this;
            _this.items = [];
            if (_this.datas) {
                _this.pageCount = Math.ceil(_this.datas.length / _this.pageSize);
                for (var i = 0; i < _this.pageSize; i++) {
                    if (_this.datas[i]) {
                        _this.items.push(_this.datas[i]);
                    };
                };
            };
        }

    },

    watch: {

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





