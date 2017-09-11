/*用于模态框的响应*/
$("#summarysetting_btn").click(function () {
    $("#SummaryModal").modal("show");
});
$("#Link_Button").click(function () {
    $("#AddAttachments_Modal").modal("show");
});
$("#publishsetting_btn").click(function () {
    $("#PublishModal").modal("show");
});
$("#keywordsetting_btn").click(function () {
    $("#KeywordModal").modal("show");
});
$("#keywordsetting_btn").click(function () {
    $("#KeywordModal").modal("show");
});
$("#coverphotosetting_btn").click(function () {
    $("#CoverPhotoModal").modal("show");
});
$("#preview_btn").click(function () {
    $.cookie('title', $("#article_title").val());
    $.cookie('content', CKEDITOR.instances.ContentPlaceHolder1_Editor1.getData());
    $.cookie('summary', $("#ArticleSummary").val() == "" ? (CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().length > 50 ? CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().substring(0, 50) : CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText()) : $("#ArticleSummary").val());
    $.cookie('usertagname', $("#usertag").find("option:selected").text());
    $.cookie('CDT', $('#dtp_input2').val());
    $.cookie('uname', $('#UserName1').text());
    $.cookie('catname', $('#cat').find("option:selected").text());
    $.cookie('subname', $("#sub")?$('#sub').find("option:selected").text():"");
    window.open('Article_Preview.aspx', '_blank');
});


/*保存发布按钮*/
$("#publish_btn").click(function () {
    var f_url = "";
    var f_name = "";
    if ($("#enclosures_id").val() != "]") {
        var json_linkfiles = eval('(' + $("#enclosures_id").val() + ')');
        for (var f in json_linkfiles) {
            f_url += json_linkfiles[f].fileurl + ",";
            f_name += json_linkfiles[f].filename + ",";
        }
        f_url = f_url.substring(0, f_url.length - 1);
    }
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/SaveArticle",
        datatype: "xml",
        data: {
            "handle": $.cookie("handle"),
            "title": $("#article_title").val(),
            "content": CKEDITOR.instances.ContentPlaceHolder1_Editor1.getData(),
            "summary": $("#ArticleSummary").val() == "" ? (CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().length > 50 ? CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().substring(0, 50) : CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText()) : $("#ArticleSummary").val(),
            "coverurl": $('#coverphotourl_input').val(),
            "catid": $("#cat").val(),
            "catname": $("#cat").find("option:selected").text(),
            "subname": $("#sub").find("option:selected").text(),
            "subid": !$("#sub").val() ? "" : $("#sub").val(),
            "usertagid": $("#usertag").val(),
            "enclosure": f_url,
            "enclosure_name": f_name,
            "islist": $("#is_list").val(),
            "iscomment": $("#is_comment").val(),
            "articletags": $('#value').text(),
            "CDT": $('#dtp_input2').text(),
            "article_id": "",
            "finished": "1",
            "author": $('#UserName1').val(),
            "tagname": $("#usertag").find("option:selected").text(),
            "randomid1": $("#randomid").val()
        },
        success: function (str) {
            alert("保存成功");
            window.location.href = "Articles_Add.aspx?ID=" + $(str).find("string").text();
        }
    });
});
/*保存草稿按钮*/
$("#draft_btn").click(function () {
    var f_url = "";
    var f_name = "";
    if ($("#enclosures_id").val() != "]") {
        var json_linkfiles = eval('(' + $("#enclosures_id").val() + ')');
        for (var f in json_linkfiles) {
            f_url += json_linkfiles[f].fileurl + ",";
            f_name += json_linkfiles[f].filename + ",";
        }
        f_url = f_url.substring(0, f_url.length - 1);
    }
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/SaveArticle",
        datatype: "xml",
        data: {
            "handle": $.cookie("handle"),
            "title": $("#article_title").val(),
            "content": CKEDITOR.instances.ContentPlaceHolder1_Editor1.getData(),
            "summary": $("#ArticleSummary").val() == "" ? (CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().length > 50 ? CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().substring(0, 50) : CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText()) : $("#ArticleSummary").val(),
            "coverurl": $('#coverphotourl_input').val(),
            "catid": $("#cat").val(),
            "subid": !$("#sub").val() ? "" : $("#sub").val(),
            "usertagid": $("#usertag").val(),
            "enclosure": f_url,
            "enclosure_name": f_name,
            "islist": $("#is_list").val(),
            "iscomment": $("#is_comment").val(),
            "articletags": $('#value').text(),
            "CDT": $('#dtp_input2').text(),
            "article_id": "",
            "finished": "0",
            "catname": $("#cat") ? $('#cat').find("option:selected").text() : "",
            "subname": $("#sub") ? $('#sub').find("option:selected").text() : "",
            "author": $('#UserName1').val(),
            "tagname": $("#usertag").find("option:selected").text(),
            "randomid1": $("#randomid").val()
        },
        success: function (str) {
            alert("保存成功");
            window.location.href = "Articles_Add.aspx?ID=" + $(str).find("string").text();
        }
    });
});
/*保存发布按钮*/
$("#publishandnew_btn").click(function () {
    var f_url = "";
    var f_name = "";
    if ($("#enclosures_id").val() != "]") {
        var json_linkfiles = eval('(' + $("#enclosures_id").val() + ')');
        for (var f in json_linkfiles) {
            f_url += json_linkfiles[f].fileurl + ",";
            f_name += json_linkfiles[f].filename + ",";
        }
        f_url = f_url.substring(0, f_url.length - 1);
    }
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/SaveArticle",
        datatype: "xml",
        data: {
            "handle": $.cookie("handle"),
            "title": $("#article_title").val(),
            "content": CKEDITOR.instances.ContentPlaceHolder1_Editor1.getData(),
            "summary": $("#ArticleSummary").val() == "" ? (CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().length > 50 ? CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText().substring(0, 50) : CKEDITOR.instances.ContentPlaceHolder1_Editor1.document.getBody().getText()) : $("#ArticleSummary").val(),
            "coverurl": $('#coverphotourl_input').val(),
            "catid": $("#cat").val(),
            "subid": !$("#sub").val() ? "" : $("#sub").val(),
            "usertagid": $("#usertag").val(),
            "enclosure": f_url,
            "enclosure_name": f_name,
            "islist": $("#is_list").val(),
            "iscomment": $("#is_comment").val(),
            "articletags": $('#value').text(),
            "CDT": $('#dtp_input2').text(),
            "article_id": "",
            "finished": "1"
        },
        success: function (str) {
            alert("保存成功");
            window.location.href = "Articles_Add.aspx";
        }
    });
});

/*?ID=123即更新文章时加载数据*/
function Myinit(article_id) {
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/Myinit",
        data: { "article_id": article_id },
        success: function (str) {
            $("#article_title").val($(str).find("Title").text());
            CKEDITOR.instances.ContentPlaceHolder1_Editor1.setData($(str).find("Content").text());
            $("#ArticleSummary").val($(str).find("Summary").text());
            nv.selected = $(str).find("CatID").text();
            nv.sub_selected = $(str).find("SubID").text();
            $("#Sub_check").val($(str).find("SubID").text());
            $("#is_list").val($(str).find("IsList").text() == "false" ? "0" : "1");
            $("#is_comment").val($(str).find("IsComment").text() == "false" ? "0" : "1");
            $("#ContentPlaceHolder1_CoverPhoto").attr('src', $(str).find("CoverImageURL").text());
            $("#coverphotourl_input").val($(str).find("CoverImageURL").text());
            $("#CDT_chose").val($(str).find("CDT").text().substring(0, 10));
        }
    });
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/Tagsinit",
        data: { "article_id": article_id },
        success: function (str) {
            var items = eval('(' + $(str).find("string").text() + ')');
            for (var item in items) {
                $('#article_tag').tags(items[item].ArticleTagName);
            }
        }
    });
    $.ajax({
        type: "post",
        url: "Articles_Add_WebService.asmx/Filesinit",
        data: { "article_id": article_id },
        success: function (str) {
            var value = "[";
            var items = eval('(' + $(str).find("string").text() + ')');
            for (var item in items) {
                value += '{"filename":"' + items[item].ResourceName + '","fileurl":"' + items[item].ResourceURL + '"},';//,"filesize":"' + [FileSizeInMB] + '"},';
            }
            value = value.substring(0, value.length - 1);
            value += ']';
            nv2.message = value;
        }
    });
}

/*用于文章标签选中添加*/
$(".tagadd").click(function () {
    $('#value').text($('#article_tag').val());
    var existing = $('#value').html().split(',')
    for (var k in existing) {
        if ($(this).val() == existing[k]) { return; };
    };
    $('#article_tag').tags($(this).val());
});
/*初始化ArticleTag*/
$(function () {
    $('#article_tag').tags();
    $('#value').text($('#article_tag').val());
    setInterval(function () {
        $('#value').text($('#article_tag').val());
    }, 500);
});
/*用于加载Cat和Sub，以及用Vue联动*/

var nv = new Vue({
    el: '#Select',
    data: {
        selected: '',
        sub_selected: '',
        has: false,
        sub_items: []
    }
    , computed: {
        items: function () {
            var a = ""
            $.ajax({
                type: "post",
                url: "Articles_Add_WebService.asmx/LoadCat",
                async: false,  //同步，既做完才往下
                success: function (str) { a = $(str).find("string").text(); }
            });
            return eval("(" + a + ")");
        }
    }
    , watch: {
        selected: function () {
            $.ajax({
                type: "post",
                url: "Articles_Add_WebService.asmx/LoadSub",
                data: { "CID": nv.selected },
                success: function (str) {
                    nv.sub_items = eval('(' + $(str).find("string").text() + ')');
                    if ($(str).find("string").text() == "[]") { nv.has = false } else nv.has = true;
                }
            })
        }
    }
});

/*用于加载用户标签*/
$.ajax({
    type: "post",
    url: "Articles_Add_WebService.asmx/UserTag",
    data: { "handle": "doinsert" },
    success: function (str) {
        var data1 = $(str).find("string").text();
        var nv = new Vue({
            el: '#UserTag_Select',
            data: {
                items: eval('(' + data1 + ')')
            }
        });
    }
});
/*附件联动加载更新*/
var nv2 = new Vue({
    el: '#Enclosure',
    data: {
        items: [],
        message: '[]',
        del_file: function (a) {
            var cont = 0;
            var del_str;
            for (var obj in nv2.items) { if (nv2.items[obj] === a) cont = obj; }
            if (cont == 0) del_str = JSON.stringify(a) + ",";
            else del_str = "," + JSON.stringify(a);
            if (nv2.items.length == 1) del_str = JSON.stringify(a);
            nv2.message = nv2.message.replace(del_str, '');
        }
    },
    watch: {
        message: function () {
            nv2.items = eval('(' + nv2.message + ')');
        }
    }
});



/*修复Bootstrap模态框与WebUpLoad不兼容的问题
 *主要方法是弹出Modal时把Modal的display改成block
 *重新初始化webuploader控件*/
$("#AddAttachments_Modal").on("show.bs.modal", function () {
    $('#AddAttachments_Modal').css("display", "block");
    var $wrap = $('#uploader'),

        // 图片容器
        $queue = $('<ul class="filelist"></ul>')
            .appendTo($wrap.find('.queueList')),

        // 状态栏，包括进度和控制按钮
        $statusBar = $wrap.find('.statusBar'),

        // 文件总体选择信息。
        $info = $statusBar.find('.info'),

        // 上传按钮
        $upload = $wrap.find('.uploadBtn'),

        // 没选择文件之前的内容。
        $placeHolder = $wrap.find('.placeholder'),

        $progress = $statusBar.find('.progress').hide(),

        // 添加的文件数量
        fileCount = 0,

        // 添加的文件总大小
        fileSize = 0,

        // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

        // 缩略图大小
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,

        // 可能有pedding, ready, uploading, confirm, done.
        state = 'pedding',

        // 所有文件的进度信息，key为file id
        percentages = {},
        // 判断浏览器是否支持图片的base64
        isSupportBase64 = (function () {
            var data = new Image();
            var support = true;
            data.onload = data.onerror = function () {
                if (this.width != 1 || this.height != 1) {
                    support = false;
                }
            }
            data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
            return support;
        })(),

        // 检测是否已经安装flash，检测flash的版本
        flashVersion = (function () {
            var version;

            try {
                version = navigator.plugins['Shockwave Flash'];
                version = version.description;
            } catch (ex) {
                try {
                    version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
                            .GetVariable('$version');
                } catch (ex2) {
                    version = '0.0';
                }
            }
            version = version.match(/\d+/g);
            return parseFloat(version[0] + '.' + version[1], 10);
        })(),

        supportTransition = (function () {
            var s = document.createElement('p').style,
                r = 'transition' in s ||
                        'WebkitTransition' in s ||
                        'MozTransition' in s ||
                        'msTransition' in s ||
                        'OTransition' in s;
            s = null;
            return r;
        })(),

        // WebUploader实例
        uploader;

    if (!WebUploader.Uploader.support('flash') && WebUploader.browser.ie) {

        // flash 安装了但是版本过低。
        if (flashVersion) {
            (function (container) {
                window['expressinstallcallback'] = function (state) {
                    switch (state) {
                        case 'Download.Cancelled':
                            alert('您取消了更新！')
                            break;

                        case 'Download.Failed':
                            alert('安装失败')
                            break;

                        default:
                            alert('安装已成功，请刷新！');
                            break;
                    }
                    delete window['expressinstallcallback'];
                };

                var swf = './expressInstall.swf';
                // insert flash object
                var html = '<object type="application/' +
                        'x-shockwave-flash" data="' + swf + '" ';

                if (WebUploader.browser.ie) {
                    html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ';
                }

                html += 'width="100%" height="100%" style="outline:0">' +
                    '<param name="movie" value="' + swf + '" />' +
                    '<param name="wmode" value="transparent" />' +
                    '<param name="allowscriptaccess" value="always" />' +
                '</object>';

                container.html(html);

            })($wrap);

            // 压根就没有安转。
        } else {
            $wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>');
        }

        return;
    } else if (!WebUploader.Uploader.support()) {
        alert('Web Uploader 不支持您的浏览器！');
        return;
    }

    // 实例化
    uploader = WebUploader.create({
        pick: {
            id: '#filePicker',
            label: '点击选择文件'
        },
        formData: {
            uid: 123
        },
        dnd: '#dndArea',
        paste: '#uploader',
        swf: 'webuploader/Uploader.swf',
        chunked: false,
        chunkSize: 512 * 1024,
        server: 'Upload2.aspx',
        accept: {
            title: '*',
            extensions: 'jpg,jpeg,png,gif,bmp,mp4,mov,flv,3gp,3g2,ogv,webm,mp3,aac,m4a,ogg,wav,swf,doc,docx,xls,xlsx,ppt,pptx,pdf,txt,zip,rar,7z,iso',
            mimeTypes: '*'
        },/*
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            },*/

        // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
        disableGlobalDnd: true,
        fileNumLimit: 50,
        fileSizeLimit: 200 * 1024 * 1024,    // 200 M
        fileSingleSizeLimit: 200 * 1024 * 1024    // 50 M



    });
    // 添加“添加文件”的按钮，
    uploader.addButton({
        id: '#filePicker2',
        label: '继续添加'
    });

    uploader.on('ready', function () {
        window.uploader = uploader;
    });

    // 当有文件添加进来时执行，负责view的创建
    function addFile(file) {
        var $li = $('<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>' +
                '<p class="progress"><span></span></p>' +
                '</li>'),

            $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span>' +
                '<span class="rotateRight">向右旋转</span>' +
                '<span class="rotateLeft">向左旋转</span></div>').appendTo($li),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find('p.imgWrap'),
            $info = $('<p class="error"></p>'),

            showError = function (code) {
                switch (code) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;

                    case 'interrupt':
                        text = '上传暂停';
                        break;

                    default:
                        text = '上传失败，请重试';
                        break;
                }

                $info.text(text).appendTo($li);
            };

        if (file.getStatus() === 'invalid') {
            showError(file.statusText);
        } else {
            // @todo lazyload
            $wrap.text('预览中');
            uploader.makeThumb(file, function (error, src) {
                var img;

                if (error) {
                    $wrap.text('不能预览');
                    return;
                }

                if (isSupportBase64) {
                    img = $('<img src="' + src + '">');
                    $wrap.empty().append(img);
                } else {
                    $.ajax('../../server/preview.php', {
                        method: 'POST',
                        data: src,
                        dataType: 'json'
                    }).done(function (response) {
                        if (response.result) {
                            img = $('<img src="' + response.result + '">');
                            $wrap.empty().append(img);
                        } else {
                            $wrap.text("预览出错");
                        }
                    });
                }
            }, thumbnailWidth, thumbnailHeight);

            percentages[file.id] = [file.size, 0];
            file.rotation = 0;
        }

        file.on('statuschange', function (cur, prev) {
            if (prev === 'progress') {
                $prgress.hide().width(0);
            } else if (prev === 'queued') {
                $li.off('mouseenter mouseleave');
                $btns.remove();
            }

            // 成功
            if (cur === 'error' || cur === 'invalid') {
                console.log(file.statusText);
                showError(file.statusText);
                percentages[file.id][1] = 1;
            } else if (cur === 'interrupt') {
                showError('interrupt');
            } else if (cur === 'queued') {
                percentages[file.id][1] = 0;
            } else if (cur === 'progress') {
                $info.remove();
                $prgress.css('display', 'block');
            } else if (cur === 'complete') {
                $li.append('<span class="success"></span>');
            }

            $li.removeClass('state-' + prev).addClass('state-' + cur);
        });

        $li.on('mouseenter', function () {
            $btns.stop().animate({ height: 30 });
        });

        $li.on('mouseleave', function () {
            $btns.stop().animate({ height: 0 });
        });

        $btns.on('click', 'span', function () {
            var index = $(this).index(),
                deg;

            switch (index) {
                case 0:
                    uploader.removeFile(file);
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
            }

            if (supportTransition) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation / 90) % 4 + 4) % 4) + ')');
            }


        });

        $li.appendTo($queue);
    }

    // 负责view的销毁
    function removeFile(file) {
        var $li = $('#' + file.id);

        delete percentages[file.id];
        updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
    }

    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;

        $.each(percentages, function (k, v) {
            total += v[0];
            loaded += v[0] * v[1];
        });

        percent = total ? loaded / total : 0;


        spans.eq(0).text(Math.round(percent * 100) + '%');
        spans.eq(1).css('width', Math.round(percent * 100) + '%');
        updateStatus();
    }

    function updateStatus() {
        var text = '', stats;

        if (state === 'ready') {
            text = '选中' + fileCount + '个文件，共' +
                    WebUploader.formatSize(fileSize) + '。';
        } else if (state === 'confirm') {
            stats = uploader.getStats();
            if (stats.uploadFailNum) {
                text = '已成功上传' + stats.successNum + '个文件，' +
                    stats.uploadFailNum + '个文件上传失败，<a class="retry" href="#">重新上传</a>失败文件或<a class="ignore" href="#">忽略</a>'
            }

        } else {
            stats = uploader.getStats();
            text = '共' + fileCount + '个（' +
                    WebUploader.formatSize(fileSize) +
                    '），已上传' + stats.successNum + '个';

            if (stats.uploadFailNum) {
                text += '，失败' + stats.uploadFailNum + '个';
            }
        }

        $info.html(text);
    }

    function setState(val) {
        var file, stats;

        if (val === state) {
            return;
        }

        $upload.removeClass('state-' + state);
        $upload.addClass('state-' + val);
        state = val;

        switch (state) {
            case 'pedding':
                $placeHolder.removeClass('element-invisible');
                $queue.hide();
                $statusBar.addClass('element-invisible');
                uploader.refresh();
                break;

            case 'ready':
                $placeHolder.addClass('element-invisible');
                $('#filePicker2').removeClass('element-invisible');
                $queue.show();
                $statusBar.removeClass('element-invisible');
                uploader.refresh();
                break;

            case 'uploading':
                $('#filePicker2').addClass('element-invisible');
                $progress.show();
                $upload.text('暂停上传');
                break;

            case 'paused':
                $progress.show();
                $upload.text('继续上传');
                break;

            case 'confirm':
                $progress.hide();
                $('#filePicker2').removeClass('element-invisible');
                $upload.text('开始上传');

                stats = uploader.getStats();
                if (stats.successNum && !stats.uploadFailNum) {
                    setState('finish');
                    return;
                }
                break;
            case 'finish':
                stats = uploader.getStats();
                if (stats.successNum) {
                    //alert('上传成功');
                    var json_enclosures = "["
                    var enclosures = $.cookie("returnfilename").split(',');
                    var enclosures_url = $.cookie("returnfileurl").split(',');
                    for (var j = 0; j < enclosures.length - 1; j++) {
                        json_enclosures += '{"filename":"' + enclosures[j] + '","fileurl":"' + enclosures_url[j] + '"},'
                    }
                    json_enclosures = json_enclosures.substring(0, json_enclosures.length - 1);
                    json_enclosures += "]";
                    nv2.message = json_enclosures;
                    //window.open('File_Upload_rename.aspx', '文件重命名', 'height=600, width=900, left=' + ((screen.width - 900) / 2) + ',top=' + ((screen.height - 600) / 2) + ', toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
                } else {
                    // 没有成功的图片，重设
                    state = 'done';
                    location.reload();
                }
                break;
        }

        updateStatus();

    }

    uploader.onUploadProgress = function (file, percentage) {
        var $li = $('#' + file.id),
            $percent = $li.find('.progress span');

        $percent.css('width', percentage * 100 + '%');
        percentages[file.id][1] = percentage;
        updateTotalProgress();
    };

    uploader.onFileQueued = function (file) {
        fileCount++;
        fileSize += file.size;

        if (fileCount === 1) {
            $placeHolder.addClass('element-invisible');
            $statusBar.show();
        }

        addFile(file);
        setState('ready');
        updateTotalProgress();
    };

    uploader.onFileDequeued = function (file) {
        fileCount--;
        fileSize -= file.size;

        if (!fileCount) {
            setState('pedding');
        }

        removeFile(file);
        updateTotalProgress();
    };

    uploader.on('all', function (type) {
        var stats;
        switch (type) {
            case 'uploadFinished':
                setState('confirm');
                break;

            case 'startUpload':
                setState('uploading');
                break;

            case 'stopUpload':
                setState('paused');
                break;

        }
    });

    uploader.onError = function (code) {
        alert('错误： ' + code);
    };

    $upload.on('click', function () {
        if ($(this).hasClass('disabled')) {
            return false;
        }

        if (state === 'ready') {
            uploader.upload();
        } else if (state === 'paused') {
            uploader.upload();
        } else if (state === 'uploading') {
            uploader.stop();
        }
    });

    $info.on('click', '.retry', function () {
        uploader.retry();
    });

    $info.on('click', '.ignore', function () {
        alert('继续上传');
    });

    $upload.addClass('state-' + state);
    updateTotalProgress();
});