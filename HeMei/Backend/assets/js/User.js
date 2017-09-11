window.onload = function () {
    $('.passwordinfo').css("display", "none");
    $('.questioninfo').css("display", "none");
    $('.roleinfo').css("display", "none");
}

var ques1, ques2, ques3;
var ans1, ans2, ans3;
var nv = new Vue({
    el: '#qus',
    data: {
        json: {
            a: '请选择密保问题',
            b: '您母亲的名字是？',
            c: '您配偶的生日是？',
            d: '您的学号或工号是？',
            e: '您母亲的生日是？',
            f: '您高中班主任的名字是？',
            g: '您父亲的姓名是？',
            h: '您配偶的姓名是？',
            i: '您初中班主任的名字是？',
            j: '您最熟悉的童年好友名字是？',
            k: '您最熟悉的学校宿舍室友名字是？',
            l: '对您影响最大的人的名字是？'
        },
        num: 1
    },
    methods:
        {
            add: function (event) {
              
                if (this.num == 1)
                {
                   
                    ques1 = $.trim($("#ques").find("option:selected").text());
                    ans1 = $.trim($("#ContentPlaceHolder1_ans").val());
                       
                      
                }
                if (this.num == 2) {
                      
                    ques2 = $.trim($("#ques").find("option:selected").text());
                    ans2 = $.trim($("#ContentPlaceHolder1_ans").val());
                    $('#next').css("display", "none");
                    $('#final').css("display", "inherit");
                       
                }
                $("#ContentPlaceHolder1_ans").val("");
                this.num += 1;
                 
                if (this.num > 1)
                {
                    $('#pre').css("display", "inherit");
                
                }
            },
            minus: function (event)
            {
                this.num -= 1;
                if (this.num == 1)
                {
                    $("#ContentPlaceHolder1_ans").val(ans1);
                    $('#pre').css("display", "none");
                }
                if (1<this.num<=  2)
                {
                    $("#ContentPlaceHolder1_ans").val(ans2);
                    $('#next').css("display", "inherit");
                    $('#final').css("display", "none");
                }
            },
            postdata: function ()
            {
                ques3 = $.trim($("#ques").find("option:selected").text());
                ans3 = $.trim($("#ContentPlaceHolder1_ans").val());
                this.$http.post('User_WebService.asmx/SaveQueToFind', {
                    Ques1: ques1,
                    Ques2: ques2,
                    Ques3: ques3,
                    Ans1: ans1,
                    Ans2: ans2,
                    Ans3: ans3
                }, {
                    emulateJSON: true
                }).then(function (res) {
                    $("#error").html("修改成功");
                }, function (res) {
                    $("#error").html("修改失败");
                });
            }
        }
});



var nv2 = new Vue({
    el: '#role',
    data: {
        selected: ''
    }
   ,mounted: function()//钩子函数，初始化
    {
        var webid = $('#ctl00_ContentPlaceHolder1_web_id').val();
        this.selected = webid;
       
    }
    , computed: {
        items: function () {
            var a = ""
            $.ajax({
                type: "post",
                url: "User_WebService.asmx/getWebData",
                async: false,  //同步，既做完才往下
                success: function (str) { a = $(str).find("string").text(); }
            });
            return eval("(" + a + ")");
        }
    }
    ,watch: {
    selected: function () {
        $.ajax({
            type: "post",
            url: "User_WebService.asmx/getValidAndRole",
            data: { "WebID": nv2.selected },
            async: false,  //同步，既做完才往下
            success: function (str) {
              
                var i = parseInt($(str).find("RoleID").text()) ;
              
              
                if (i.length != 0 && i != 1 && !isNaN(i)) {//有值
                   
                    $("input:radio[name='ctl00$ContentPlaceHolder1$Role']").eq(i-1).attr("checked", 'checked');

                }
                else if (isNaN(i)) {
                  
                    $("input:radio[name='ctl00$ContentPlaceHolder1$Role']").attr("checked", false);
                }
                else {//Role为1(Root)
                  
                    $("input:radio[name='ctl00$ContentPlaceHolder1$Role']").attr("checked", false);
                }

          
                //if (Boolean($(str).find("Valid").text()) == true) {
                   
                //    $('#ctl00_ContentPlaceHolder1_true1').attr("checked", "checked");
                //} else
                //{
                   
                    //$('#ctl00_ContentPlaceHolder1_false1').attr("checked", "checked");
                //}
            },
            error: function (msg) {
           
                console.log(msg);

            }
        })
    }
    }
    , methods:
     {
         updateWebsUsers: function ()
         {
             var roleID = $("input[name='ctl00$ContentPlaceHolder1$Role']:checked").val();//*同一组的radio选中的value值
             $.ajax({
                 type: "post",
                 url: "User_WebService.asmx/insertWebsUsers",
                 data: { "WebID": nv2.selected, "RoleID": roleID },
                 success: function (str)
                         {
                               alert("操作成功");
                               console.log(str);
                         },
                 error: function (msg) {

                     console.log(msg);

                 }
             })
         }
     }
  

})

var Uarry = $(".filter li");//获取所有的li元素 
$(".nav li").click(function () {//点击事件       

    var count = $(this).index();//获取li的下标  
    if (count == 0)
    {
        $('.userinfo').css("display", "inherit");
        $('.questioninfo').css("display", "none");
        $('.passwordinfo').css("display", "none");
        $('.roleinfo').css("display", "none");
    }
    if (count == 1)
    {
        $('.userinfo').css("display", "none");
        $('.questioninfo').css("display", "none");
        $('.roleinfo').css("display", "none");
        $('.passwordinfo').css("display", "inherit");
    }
    if (count == 2)
    {
        $('.userinfo').css("display", "none");
        $('.passwordinfo').css("display", "none");
        $('.roleinfo').css("display", "none");
        $('.questioninfo').css("display", "inherit");
    }
    if (count == 3)
    {
        $('.userinfo').css("display", "none");
        $('.passwordinfo').css("display", "none");
        $('.questioninfo').css("display", "none");
        $('.roleinfo').css("display", "inherit");
    }

});


$("#Save_Info").click(function () {

    var birthDate = $("#ContentPlaceHolder1_Birth_Date").val();
    var phone = $("#ContentPlaceHolder1_Tel").val();
    var status = $("#ContentPlaceHolder1_Signature").val();

    $.ajax({
        type: "post",
        url: "User_WebService.asmx/SaveUserInfo",
        data: {
            "BirthDate": birthDate,
            "Phone": phone,
            "Status": status
        },
        success: function (str) {
            $("#ContentPlaceHolder1_LabelError").html("修改成功");
        },
        error: function (msg) {
            $("#ContentPlaceHolder1_LabelError").html("修改失败");

        }
    })
})


//做个下简易的验证  大小 格式 
$('#avatarInput').on('change', function (e) {
    var filemaxsize = 1024 * 3;//5M
    var target = $(e.target);
    var Size = target[0].files[0].size / 1024;
    if (Size > filemaxsize) {
        alert('图片过大，请重新选择!');
        $(".avatar-wrapper").childre().remove;
        return false;
    }
    if (!this.files[0].type.match(/image.*/)) {
        alert('请选择正确的图片!')
    } else {
        var filename = document.querySelector("#avatar-name");
        var texts = document.querySelector("#avatarInput").value;
        var teststr = texts; //你这里的路径写错了
        testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
        filename.innerHTML = testend;
    }

});


$(".avatar-save").on("click", function () {

    var img_lg = document.getElementById('imageHead');
    // 截图小的显示框内的内容
    html2canvas(img_lg, {
        allowTaint: true,
        taintTest: false,
        onrendered: function (canvas) {
            canvas.id = "mycanvas";
            //生成base64图片数据
            var dataUrl = canvas.toDataURL("image/jpeg");
            var newImg = document.createElement("img");
            newImg.src = dataUrl;
            imagesAjax(dataUrl);
        }
    });
})

function imagesAjax(src) {
    var data = {};
    data.img = src;
    data.jid = $('#jid').val();
    $.ajax({
        type: 'post',
        url: 'Avatar_Upload.ashx',
        //data: data,
        data: { img: src, id: $('#jid').val() },
        success: function (ex) {
            console.log('修改成功');
            window.location.reload();

        }
    });
}
