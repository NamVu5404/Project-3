<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/1/2024
  Time: 9:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:url var="buildingListUrl" value="/admin/building-list"/>
<c:url var="buildingAPI" value="/api/buildings/"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
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
                <h1>Danh sách tòa nhà</h1>
            </div><!-- /.page-header -->

            <form:form action="${buildingListUrl}" modelAttribute="model" method="GET" id="listForm">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="widget-box" style="font-family: 'Times New Roman', Times, serif;">
                            <div class="widget-header">
                                <h4 class="widget-title">Tìm kiếm</h4>

                                <span class="widget-toolbar">
                        <a href="#" data-action="settings">
                          <i class="ace-icon fa fa-cog"></i>
                        </a>

                        <a href="#" data-action="reload">
                          <i class="ace-icon fa fa-refresh"></i>
                        </a>

                        <a href="#" data-action="collapse">
                          <i class="ace-icon fa fa-chevron-up"></i>
                        </a>
                      </span>
                            </div>

                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-6">
                                                    <label>Tên tòa nhà</label>
                                                    <form:input class="form-control" path="name"/>
                                                </div>

                                                <div class="col-sm-6">
                                                    <label>Diện tích sàn</label>
                                                    <form:input type="number" class="form-control" path="floorArea"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-2">
                                                    <label>Quận</label>
                                                    <form:select class="form-control" path="district">
                                                        <form:option value="" label="---Chọn quận---"/>
                                                        <form:options items="${district}"/>
                                                    </form:select>
                                                </div>

                                                <div class="col-sm-5">
                                                    <label>Phường</label>
                                                    <form:input class="form-control" path="ward"/>
                                                </div>

                                                <div class="col-sm-5">
                                                    <label>Đường</label>
                                                    <form:input class="form-control" path="street"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-4">
                                                    <label>Số tầng hầm</label>
                                                    <form:input type="number" class="form-control"
                                                                path="numberOfBasement"/>
                                                </div>

                                                <div class="col-sm-4">
                                                    <label>Hướng</label>
                                                    <form:input class="form-control" path="direction"/>
                                                </div>

                                                <div class="col-sm-4">
                                                    <label>Hạng</label>
                                                    <form:input class="form-control" path="level"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-3">
                                                    <label>Diện tích từ</label>
                                                    <form:input type="number" class="form-control" path="areaFrom"/>
                                                </div>

                                                <div class="col-sm-3">
                                                    <label>Diện tích đến</label>
                                                    <form:input type="number" class="form-control" path="areaTo"/>
                                                </div>

                                                <div class="col-sm-3">
                                                    <label>Giá thuê từ</label>
                                                    <form:input type="number" class="form-control"
                                                                path="rentPriceFrom"/>
                                                </div>

                                                <div class="col-sm-3">
                                                    <label>Giá thuê đến</label>
                                                    <form:input type="number" class="form-control" path="rentPriceTo"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-5">
                                                    <label>Tên quản lý</label>
                                                    <form:input class="form-control" path="managerName"/>
                                                </div>

                                                <div class="col-sm-5">
                                                    <label>SĐT quản lý</label>
                                                    <form:input class="form-control" path="managerPhone"/>
                                                </div>

                                                <div class="col-sm-2">
                                                    <security:authorize access="hasRole('MANAGER')">
                                                        <label>Nhân viên phụ trách</label>
                                                        <form:select class="form-control" path="staffId">
                                                            <form:option value="" label="---Chọn nhân viên---"/>
                                                            <form:options items="${staffs}"/>
                                                        </form:select>
                                                    </security:authorize>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-6">
                                                    <form:checkboxes path="typeCode" items="${typeCodes}"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-12">
                                                    <button class="btn btn-sm btn-primary" id="btnSearchBuilding">
                                                        <i class="ace-icon glyphicon glyphicon-search"></i>
                                                        Tìm kiếm
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pull-right">
                            <security:authorize access="hasRole('MANAGER')">
                                <a href="/admin/building-edit">
                                    <button type="button" title="Thêm tòa nhà" class="btn btn-success">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor"
                                             class="bi bi-building-add" viewBox="0 0 16 16">
                                            <path
                                                    d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                            <path
                                                    d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                            <path
                                                    d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                        </svg>
                                    </button>
                                </a>

                                <button type="button" title="Xóa tất cả tòa nhà" class="btn btn-danger"
                                        id="btnDeleteBuildings">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-building-dash" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1"/>
                                        <path
                                                d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                        <path
                                                d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                    </svg>
                                </button>
                            </security:authorize>
                        </div>
                    </div>
                </div>
            </form:form>

            <div class="hr hr-18 dotted hr-double"></div>

            <div class="row">
                <div class="col-xs-12">
                    <display:table name="model.listResult" cellspacing="0" cellpadding="0"
                                   requestURI="${buildingListUrl}" partialList="true" sort="external"
                                   size="${model.totalItems}" defaultsort="2" defaultorder="ascending"
                                   id="tableList" pagesize="${model.maxPageItems}"
                                   export="false"
                                   class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                   style="margin: 3em 0 1.5em;">
                        <display:column title="<fieldset class='form-group'>
												        <input type='checkbox' id='checkAll' class='check-box-element'>
												        </fieldset>" class="center select-cell"
                                        headerClass="center select-cell">
                            <fieldset>
                                <input type="checkbox" name="checkList" value="${tableList.id}"
                                       id="checkbox_${tableList.id}" class="check-box-element"/>
                            </fieldset>
                        </display:column>
                        <display:column headerClass="text-left" property="name" title="Tên tòa nhà"/>
                        <display:column headerClass="text-left" property="address" title="Địa chỉ"/>
                        <display:column headerClass="text-left" property="numberOfBasement" title="Số tầng hầm"/>
                        <display:column headerClass="text-left" property="managerName" title="Tên quản lý"/>
                        <display:column headerClass="text-left" property="managerPhone" title="SĐT quản lý"/>
                        <display:column headerClass="text-left" property="floorArea" title="D.Tích sàn"/>
                        <display:column headerClass="text-left" property="emptyArea" title="D.Tích trống"/>
                        <display:column headerClass="text-left" property="rentArea" title="D.Tích thuê"/>
                        <display:column headerClass="text-left" property="rentPrice" title="Giá thuê"/>
                        <display:column headerClass="text-left" property="serviceFee" title="Phí dịch vụ"/>
                        <display:column headerClass="text-left" property="brokerageFee" title="Phí MG"/>
                        <display:column headerClass="col-actions" title="Thao tác">
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-success" title="Giao tòa nhà"
                                        onclick="assignmentBuilding(${tableList.id})">
                                    <i class="ace-icon glyphicon glyphicon-list"></i>
                                </button>
                            </security:authorize>

                            <a href="/admin/building-edit-${tableList.id}">
                                <button class="btn btn-sm btn-info" title="Sửa tòa nhà">
                                    <i class="ace-icon fa fa-pencil-square-o"></i>
                                </button>
                            </a>

                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-danger" title="Xóa tòa nhà"
                                        onclick="btnDeleteBuilding(${tableList.id})">
                                    <i class="ace-icon glyphicon glyphicon-trash"></i>
                                </button>
                            </security:authorize>
                        </display:column>
                    </display:table>
                </div>
            </div>
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->

<!-- Modal -->
<div id="assignmentBuildingModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>

            <div class="modal-body">
                <table class="table table-bordered" id="staffIdList"
                       style="font-family: 'Times New Roman', Times, serif;">
                    <thead>
                    <tr>
                        <th class="center">Chọn</th>
                        <th class="center">Tên nhân viên</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <input type="hidden" id="buildingId" name="buildingId" value="">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAssignmentBuilding">Giao tòa nhà</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End Modal -->

<script>
    const assignmentBuilding = buildingId => {
        $(`#assignmentBuildingModal`).modal();
        $(`#buildingId`).val(buildingId);
        loadStaffs(buildingId);
    }

    const loadStaffs = (buildingId) => {
        $.ajax({
            type: "GET",
            url: "${buildingAPI}" + buildingId + "/staffs",
            dataType: "json",
            success: (response) => {
                var row = '';
                $.each(response.data, (_, item) => {
                    row += '<tr>';
                    row += '<td class="center"><input type="checkbox" value=' + item.staffId + ' id="checkbox_' + item.staffId + '" ' + item.checked + '/></td>';
                    row += '<td class="center">' + item.fullName + '</td>';
                    row += '</tr>'
                });
                $('#staffIdList tbody').html(row);
            },
            error: (response) => {
                console.log(response);
            }
        });
    }

    $(`#btnAssignmentBuilding`).click(e => {
        e.preventDefault();
        var data = {};
        data.buildingId = $(`#buildingId`).val();
        data.staffs = $(`#staffIdList`).find(`tbody input[type=checkbox]:checked`).map(function () {
            return $(this).val();
        }).get();

        $.ajax({
            type: "PUT",
            url: "${buildingAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: () => {
                alert("Giao tòa nhà thành công!");
            },
            error: () => {
                alert("Giao tòa nhà không thành công!");
            }
        });
    });

    $('#btnDeleteBuildings').click(function (e) {
        e.preventDefault();
        var data = {};
        data.buildingIds = $('tbody input[type=checkbox]:checked').map(function () {
            console.log($(this));
            return $(this).val();
        }).get();
        deleteBuilding(data);
    });

    const btnDeleteBuilding = (buildingId) => {
        deleteBuilding({"buildingIds": [buildingId]});
    }

    const deleteBuilding = (data) => {
        $.ajax({
            type: "DELETE",
            url: "${buildingAPI}" + data.buildingIds,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "text",
            success: (response) => {
                alert(response);
                window.location.replace("/admin/building-list");
            },
            error: (response) => {
                console.log("Xóa không thành công!");
                console.log(response);
            }
        });
    }

    $(`#btnSearchBuilding`).click(e => {
        e.preventDefault();
        $(`#listForm`).submit();
    })

</script>
</body>
</html>
