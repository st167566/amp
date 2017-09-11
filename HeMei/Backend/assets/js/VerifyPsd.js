function checkpsd1() {
    psd1 = $("#ctl00_ContentPlaceHolder1_Password2").val();
    var flagZM = false;

    var flagSZ = false;

    var flagQT = false;

    if (psd1.length < 6 || psd1.length > 30) {

        divpassword1.innerHTML = '<font class="tips_false">长度错误</font>';
        $("#ctl00_ContentPlaceHolder1_Psd_Upd").attr("disabled", true);

    } else {
        for (i = 0; i < psd1.length; i++) {
            if ((psd1.charAt(i) >= 'A' && psd1.charAt(i) <= 'Z') || (psd1.charAt(i) >= 'a' && psd1.charAt(i) <= 'z')) {
                flagZM = true;
            }
            else if (psd1.charAt(i) >= '0' && psd1.charAt(i) <= '9') {
                flagSZ = true;
            }
            else {
                flagQT = true;
            }
        }
        if (!flagZM || !flagSZ || flagQT) {
            $("#ctl00_ContentPlaceHolder1_Psd_Upd").attr("disabled", true);
            divpassword1.innerHTML = '<font class="tips_false">密码必须是字母数字的组合</font>';
        } else {
            $("#ctl00_ContentPlaceHolder1_Psd_Upd").attr("disabled", false);
            divpassword1.innerHTML = '<font class="tips_true">输入正确</font>';
        }
    }
    //alert("hello");
}

function checkpsd2() {
    psd1 = $("#ctl00_ContentPlaceHolder1_Password2").val();
    psd2 = $("#ctl00_ContentPlaceHolder1_Password3").val();
    if (psd1 == psd2) {
        divpassword2.innerHTML = '<font class="tips_false">两次密码输入一致</font>';
        $("#ctl00_ContentPlaceHolder1_Psd_Upd").attr("disabled", false);
        $("#ctl00_ContentPlaceHolder1_Hidden2").value = 1;

    }
    else {
        $("#ctl00_ContentPlaceHolder1_Psd_Upd").attr("disabled", true);
        divpassword2.innerHTML = '<font class="tips_false">两次密码输入不一致</font>';
    }
}