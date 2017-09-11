$("#catAdd").click(function () {
    $("#addCatModal").modal("show");
});
$("#subAdd").click(function () {
    $("#addSubModal").modal("show");
});

$(".catmenu").css("display", "none");


/*用于加载一级菜单*/
$.ajax({
    type: "post",
    url: "User_WebService.asmx/loadCatMenu",
    data: { handle: "GetMenu" },
    success: function (str) {
        var data1 = $(str).find("string").text();
        var nv = new Vue({
            el: '#isAddCatMenu',
            data: {
                items: eval('(' + data1 + ')')
            }
        });
        var nv2 = new Vue({
            el: '#submenu2',
            data: {
                items2: eval('(' + data1 + ')')
            }
        });
        var nv3 = new Vue({
            el: '#submenu3',
            data: {
                items3: eval('(' + data1 + ')')
            }
        });
        var nv5 = new Vue({
            el: '#submenu5',
            data: {
                items5: eval('(' + data1 + ')')
            }
        });
       
    }
});

/*用于加载一级栏目*/
$.ajax({
    type: "post",
    url: "User_WebService.asmx/loadCatMenu",
    data: { handle: "" },
    success: function (str) {
        var data1 = $(str).find("string").text();
        var nv6 = new Vue({
            el: '#submenu',
            data: {
                items6: eval('(' + data1 + ')')
            }
        });
        var nv4 = new Vue({
            el: '#submenu4',
            data: {
                items4: eval('(' + data1 + ')')
            }
        });
    }
});


var catMenuID = 0;
$(function () {
    $("input[name='IsAddSubMenu']").click(function () {
        var value = $(this).attr("value");
        if (value == 1) {
            $("#submenu2").css("display", "inline-block");
            catMenuID = $(".catmenu option:selected").val();
        } else { $("#submenu2").css("display", "none"); catMenuID = 0; }
    });
});
//增加二级栏目
$("#AddSub").click(function () {
   
    var valid = $("input[name='subValid']:checked").val() ? $("input[name='subValid']:checked").val() : "0";
    var catID = $("#submenu option:selected").val();
    var menuRank = $("input[name='IsMenu']:checked").val() ? $("input[name='IsMenu']:checked").val() : "";//0为一级，1为二级
    var isMenu = 0;
    if (menuRank != null) {
        isMenu = 1;//1为true

    }

    alert(catID);
    if (!!$("#subName").val()) {//检查是否为空

        $.ajax({
            type: "post",
            url: "User_WebService.asmx/addSub",
            data: {
                SubName: $("#subName").val(),
                SubHref: $("#subhref").val(),
                SubDescription: $("#subDescription").val(),
                Valid: valid,
                CatID: catID,
                IsMenu: isMenu,
                MenuRank: menuRank,
                CatMenuID: catMenuID

            },
            success: function (str) {
                a = $(str).find("int").text();

            }, error: function (msg) {

            }
        })
        alert("二级");

    } else {
        alert("请把相关信息填写完整");
    }

})


$(function () {
    $("input[name='IsAddCatMenu']").click(function () {
        var value = $(this).attr("value");
        if (value == 1) {
            $("#isAddCatMenu").css("display", "inline-block");
            catMenuID = $(".catmenu option:selected").val();
        } else { $("#isAddCatMenu").css("display", "none"); catMenuID = 0; }
    });
});
//增加一级栏目
$("#AddCat").click(function () {
  
    var valid = $("input[name='Valid']:checked").val() ? $("input[name='Valid']:checked").val() : "0";
    var isShow = $("input[name='IsShow']:checked").val() ? $("input[name='IsShow']:checked").val() : "";
    var menuRank = $("input[name='IsMenu']:checked").val() ? $("input[name='IsMenu']:checked").val() : "";//0为一级，1为二级
    var isMenu = 0;
    if (menuRank != null) {
        isMenu = 1;//1为true

    }

    if (!!$("#CatName").val()) {//检查是否为空

        $.ajax({
            type: "post",
            url: "User_WebService.asmx/addCat",
            data: {
                CatName: $("#CatName").val(),
                Href: $("#href").val(),
                CatDescription: $("#catDescription").val(),
                Valid: valid,
                IsShow: isShow,
                IsMenu: isMenu,
                MenuRank: menuRank,
                CatMenuID: catMenuID

            },
            success: function (str) {
                a = $(str).find("int").text();

            }
        })

    } else {
        alert("请把相关信息填写完整");
    }
})

          var app =  new Vue({
                el: '#box',
                data:{
                    datas: [],//总的数据
                },
                created: function () {//加载数据items
                    var a = "";
                    $.ajax({
                        type: "get",
                        url: "User_WebService.asmx/InitCatMan",
                        async: false,  //同步，既做完才往下
                        success: function (str) { a = $(str).find("string").text(); }
                    });
                    var json = eval('(' + a + ')');
                    this.datas = json;
                 
                },
                components: {
                    'child-com': {
                        props: ['msg','name'],
                        template: '#child',
                        data: {
                            items: []
                        },
                        methods: {
                            change() {
                                this.msg = '被更改了';
                                
                            }
                        },
                        //mounted: function () {//加载数据items
                        //    var a = "";
                        //    $.ajax({
                        //        type: "get",
                        //        data: { CatID: 19},
                        //        url: "User_WebService.asmx/InitSubMan",
                        //        async: false,
                        //        success: function (str) { a = $(str).find("string").text();  }
                        //    });
                        //    var json = eval('(' + a + ')');
                        //    this.items = json;
                        //    //for (var i in this.items) {
                        //    //    alert(this.items[i].);

                        //    //}
                          
                         
                        //}
                    }
                }
          });




//修改栏目信息模块
      $('#editCatModal').on("show.bs.modal", function (e) {
              $(function () {
                  $("input[name='IsEditCatMenu']").click(function () {
                      var value = $(this).attr("value");
                      if (value == 1) {
                          $("#submenu3").css("display", "inline-block");
                          catMenuID = $(".catmenu option:selected").val();
                      } else { $("#submenu3").css("display", "none"); catMenuID = 0; }
                  });
              });
              var btn = $(e.relatedTarget),
                  iid = btn.parent().data("id");//取父节点
              $.ajax({
                  type: "get",
                  data: { CatID: iid },
                  url: "User_WebService.asmx/showCatInfo",
                  async: false,
                  success: function (str) {
                      $('#infoCatName').val($(str).find("CatName").text());//val(val)是jquery函数，最容易混淆的是获取input的函数是val()
                      $('#infohref').val($(str).find("Href").text());
                      $('#catinfoDescription').val($(str).find("Description").text());
                      if (String($(str).find("Valid").text()) == "true") {
                      
                          $("input:radio[name='infoValid']").eq(0).attr("checked", true);
               
                      } else
                      {
                         
                          $("input:radio[name='infoValid']").eq(1).attr("checked", true);
                      }

                      if (String($(str).find("IsShow").text()) == "true") {
                          $("input:radio[name='infoIsShow']").eq(1).attr("checked", true);
                      } else
                      {
                          $("input:radio[name='infoIsShow']").eq(0).attr("checked", true);
                      }
                 
                      if (String($(str).find("MenuRank").text()) == "true") {
                          $(".catmenu").css("display", "inline-block");
                          $("#infosubMenu").attr("checked", true);
                          
                      }
                      if (String($(str).find("MenuRank").text()) == "false") {
                          $("#infocatMenu").attr("checked", true);
                      }

                  }
              })

              //修改一级栏目
              $("#editCat").click(function () {
                  var valid = $("input[name='infoValid']:checked").val() ? $("input[name='infoValid']:checked").val() : "0";
                  var isShow = $("input[name='infoIsShow']:checked").val() ? $("input[name='infoIsShow']:checked").val() : "";
                  var menuRank = $("input[name='IsMenu']:checked").val() ? $("input[name='IsMenu']:checked").val() : "";//0为一级，1为二级
                  var isMenu = 0;
                  if (menuRank != null) {
                      isMenu = 1;//1为true

                  }
                  $.ajax({
                      type: "post",
                      url: "User_WebService.asmx/editCat",
                      data: {
                          CatID: iid,
                          CatName: $("#infoCatName").val(),
                          Href: $("#infohref").val(),
                          CatDescription: $("#catinfoDescription").val(),
                          Valid: valid,
                          IsShow: isShow,
                          IsMenu: isMenu,
                          MenuRank: menuRank,
                          CatMenuID: catMenuID

                      },
                      success: function (str) {
                          console.log("Sucess");

                      }
                  })
                 
              });

              //删除一级栏目
              $("#delCat").click(function () {
                  $.ajax({
                      type: "post",
                      url: "User_WebService.asmx/delCat",
                      data: { CatID: iid },
                      success: function (str) {
                          console.log("Sucess");

                      }
                  })
              })
          })



//修改二级栏目
  $('#editSubModal').on("show.bs.modal", function (e) {

              var catMenuID = 0;
              //监听修改二级栏目菜单的变化情况
              $(function () {
                  $("input[name='IsSubEditMenu']").click(function () {
                      var value = $(this).attr("value");
                      if (value == 1) {
                          $("#submenu5").css("display", "inline-block");
                          catMenuID = $("#submenu5 option:selected").val();
                      } else { $("#submenu5").css("display", "none"); catMenuID = 0; }
                  });
              });
           
     var btn = $(e.relatedTarget),
                 iid = btn.next().data("id");//取兄弟节点
         $.ajax({
             type: "post",
             url: "User_WebService.asmx/showSubInfo",
             data: { SubID: iid},
             success: function (str) {
                 $('#subinfoName').val($(str).find("SubName").text());//val(val)是jquery函数，最容易混淆的是获取input的函数是val()
                 $('#subinfohref').val($(str).find("Href").text());
                 $('#subinfoDescription').val($(str).find("Description").text());
                 if (String($(str).find("Valid").text()) == "true") {

                     $("input:radio[name='subinfoValid']").eq(0).attr("checked", true);

                 } else {

                     $("input:radio[name='subinfoValid']").eq(1).attr("checked", true);
                 }
                 $("#submenu4").val($(str).find("CatID").text());//设置selector选中
                 if (String($(str).find("MenuRank").text()) == "true") {
                     $(".catmenu").css("display", "inline-block");
                     $("#subinfoMenu").attr("checked", true);

                 }
                 if (String($(str).find("MenuRank").text()) == "false") {
                     $("#catinfoMenu").attr("checked", true);
                 }

             }, error: function (msg) {

             }
         })


         $("#editSub").click(function () {
             var valid = $("input[name='subinfoValid']:checked").val() ? $("input[name='subinfoValid']:checked").val() : "0";
             var menuRank = $("input[name='IsSubEditMenu']:checked").val() ? $("input[name='IsSubEditMenu']:checked").val() : "";//0为一级，1为二级
             var isMenu = 0;
             if (menuRank != null) {
                 isMenu = 1;//1为true

             }
       
             $.ajax({
                 type: "post",
                 url: "User_WebService.asmx/editSub",
                 data: {
                     SubID: iid,
                     CatID: $("#submenu4 option:selected").val(),
                     SubName: $("#subinfoName").val(),
                     Href: $("#subinfohref").val(),
                     SubDescription: $("#subinfoDescription").val(),
                     Valid: valid,
                     IsMenu: isMenu,
                     MenuRank: menuRank,
                     CatMenuID: catMenuID

                 },
                 success: function (str) {
                   
                     console.log("Sucess");

                 }
             })
       
         });
   
 })


  $('#delSubModal').on("show.bs.modal", function (e) {
      var btn = $(e.relatedTarget),
                iid = btn.prev().data("id");//取兄弟节点
      //删除二级栏目
      $("#delSub").click(function () {
          $.ajax({
              type: "post",
              url: "User_WebService.asmx/delSub",
              data: { SubID: iid },
              success: function (str) {
                  console.log("Sucess");

              }
          })
      })

  })


    
