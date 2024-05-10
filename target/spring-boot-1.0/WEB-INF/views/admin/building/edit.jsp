<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/2/2024
  Time: 10:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingEditUrl" value="/admin/building-edit"/>
<c:url var="buildingAPI" value="/api/buildings/"/>
<html>
<head>
    <title>Thông tin tòa nhà</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Home</a>
                </li>

                <li>
                    <a href="#">UI &amp; Elements</a>
                </li>
                <li class="active">Content Sliders</li>
            </ul><!-- /.breadcrumb -->
        </div>

        <div class="page-content">
            <div class="page-header">
                <h1>Thông tin tòa nhà</h1>
            </div><!-- /.page-header -->

            <div class="row">
                <form:form modelAttribute="buildingEdit" action="${buildingEditUrl}" method="GET" id="editForm">
                    <div class="col-xs-12">
                        <form class="form-horizontal" role="form" style="font-family: 'Times New Roman', Times, serif;">
                            <div class="form-group hidden">
                                <label class="col-xs-3">ID tòa nhà</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="id"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tên tòa nhà</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="name"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Quận</label>

                                <div class="col-xs-4">
                                    <form:select class="form-control" path="district">
                                        <form:option value="" label="---Chọn quận---"/>
                                        <form:options items="${district}"/>
                                    </form:select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phường</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="ward"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Đường</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="street"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Kết cấu</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="structure"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Số tầng hầm</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="number" path="numberOfBasement"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Diện tích sàn</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="number" path="floorArea"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Hướng</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="direction"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Hạng</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="level"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Diện tích thuê</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="rentArea"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Giá thuê</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="number" path="rentPrice"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Mô tả giá</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="rentPriceDescription"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí dịch vụ</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="serviceFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí ô tô</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="carFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí mô tô</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="motoFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí ngoài giờ</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="overtimeFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tiền nước</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="waterFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tiền điện</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="electricityFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Đặt cọc</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="deposit"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thanh toán</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="payment"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thời hạn thuê</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="rentTime"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thời gian trang trí</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="decorationTime"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tên quản lý</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="managerName"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">SĐT quản lý</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="managerPhone"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí môi giới</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="brokerageFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Loại tòa nhà</label>

                                <div class="col-sm-9">
                                    <form:checkboxes path="typeCode" items="${typeCodes}"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Ghi chú</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="note"/>
                                </div>
                            </div>

                            <div class="form-group" style="margin-bottom: 100px">
                                <label class="col-xs-3"></label>

                                <div class="col-sm-9">
                                    <c:if test="${empty buildingEdit.id}">
                                        <button type="button" class="btn btn-sm btn-primary"
                                                id="btnAddOrUpdateBuilding">
                                            Thêm tòa nhà
                                        </button>
                                    </c:if>

                                    <c:if test="${not empty buildingEdit.id}">
                                        <button type="button" class="btn btn-sm btn-warning"
                                                id="btnAddOrUpdateBuilding">
                                            Sửa tòa nhà
                                        </button>
                                    </c:if>

                                    <a href="/admin/building-list">
                                        <button type="button" class="btn btn-sm btn-primary">
                                            Hủy thao tác
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </form:form>
            </div>
        </div>
    </div><!-- /.page-content -->
</div><!-- /.main-content -->

<script>
    $(`#btnAddOrUpdateBuilding`).click(() => {
        var data = {};
        var typeCode = [];
        var formData = $('#editForm').serializeArray();
        $.each(formData, (_, item) => {
            if (item.name !== "typeCode") {
                data["" + item.name + ""] = item.value;
            } else {
                typeCode.push(item.value);
            }
        })
        data.typeCode = typeCode;
        if (typeCode.length === 0) {
            return alert("Loại tòa nhà không được thiếu");
        } else if (!data.rentArea || data.rentArea.trim().length === 0) {
            return alert("Diện tích thuê không được thiếu")
        } else if (!data.name || data.name.trim().length === 0) {
            return alert("Tên tòa nhà không được thiếu");
        } else {
            btnAddOrUpdate(data);
        }
    })

    const btnAddOrUpdate = (data) => {
        $.ajax({
            type: "POST",
            url: "${buildingAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: (response) => {
                alert(response);
                window.location.replace("/admin/building-list");
            },
            error: (response) => {
                console.log("failed");
                console.log(response);
            }
        });
    }
</script>
</body>
</html>
