<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:url var="customerListUrl" value="/admin/customer-list"/>
<c:url var="customerAPI" value="/api/customers/"/>
<html>
<head>
    <title>Danh sách khách hàng</title>
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
                <h1>Danh sách khách hàng</h1>
            </div><!-- /.page-header -->

            <form:form action="${customerListUrl}" modelAttribute="model" method="GET" id="listForm">
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
                                                <div class="col-sm-4">
                                                    <label>Tên khách hàng</label>
                                                    <form:input class="form-control" path="fullName"/>
                                                </div>

                                                <div class="col-sm-4">
                                                    <label>Di động</label>
                                                    <form:input class="form-control" path="phone"/>
                                                </div>

                                                <div class="col-sm-4">
                                                    <label>Email</label>
                                                    <form:input class="form-control" path="email"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <security:authorize access="hasRole('MANAGER')">
                                                    <div class="col-sm-4">
                                                        <label>Chọn nhân viên</label>
                                                        <form:select class="form-control" path="staffId">
                                                            <form:option value="" label="---Chọn nhân viên---"/>
                                                            <form:options items="${staffs}"/>
                                                        </form:select>
                                                    </div>
                                                </security:authorize>

                                                <div class="col-sm-4">
                                                    <label>Tình trạng</label>
                                                    <form:select class="form-control" path="status">
                                                        <form:option value="" label="---Chọn tình trạng---"/>
                                                        <form:options items="${status}"/>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-12">
                                                    <button class="btn btn-sm btn-primary" id="btnSearchCustomer">
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
                            <a href="/admin/customer-edit">
                                <button type="button" title="Thêm khách hàng" class="btn btn-success">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-person-fill-add" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                        <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
                                    </svg>
                                </button>
                            </a>

                            <security:authorize access="hasRole('MANAGER')">
                                <button type="button" title="Xóa tất cả khách hàng" class="btn btn-danger"
                                        id="btnDeleteCustomers">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-person-fill-dash" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                        <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
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
                                   requestURI="${customerListUrl}" partialList="true" sort="external"
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
                        <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>
                        <display:column headerClass="text-left" property="phone" title="Di động"/>
                        <display:column headerClass="text-left" property="email" title="Email"/>
                        <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>
                        <display:column headerClass="text-left" property="createdBy" title="Người thêm"/>
                        <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>
                        <display:column headerClass="text-left" property="status" title="Tình trạng"/>
                        <display:column headerClass="col-actions" title="Thao tác">
                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-success" title="Giao khách hàng"
                                        onclick="assignmentCustomer(${tableList.id})">
                                    <i class="ace-icon glyphicon glyphicon-list"></i>
                                </button>
                            </security:authorize>

                            <a href="/admin/customer-edit-${tableList.id}">
                                <button class="btn btn-sm btn-info" title="Sửa khách hàng">
                                    <i class="ace-icon fa fa-pencil-square-o"></i>
                                </button>
                            </a>

                            <security:authorize access="hasRole('MANAGER')">
                                <button class="btn btn-sm btn-danger" title="Xóa khách hàng"
                                        onclick="btnDeleteCustomer(${tableList.id})">
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
<div id="assignmentCustomerModal" class="modal fade" role="dialog">
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
                <input type="hidden" id="customerId" name="customerId" value="">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAssignmentCustomer">Giao nhân viên</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- End Modal -->

<script>
    const assignmentCustomer = customerId => {
        $(`#assignmentCustomerModal`).modal();
        $(`#customerId`).val(customerId);
        loadStaffs(customerId);
    }

    const loadStaffs = (customerId) => {
        $.ajax({
            type: "GET",
            url: "${customerAPI}" + customerId + "/staffs",
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

    $(`#btnAssignmentCustomer`).click(e => {
        e.preventDefault();
        var data = {};
        data.customerId = $(`#customerId`).val();
        data.staffs = $(`#staffIdList`).find(`tbody input[type=checkbox]:checked`).map(function () {
            return $(this).val();
        }).get();

        $.ajax({
            type: "PUT",
            url: "${customerAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: () => {
                alert("Giao khách hàng thành công!");
            },
            error: () => {
                alert("Giao khách hàng không thành công!");
            }
        });
    });

    $('#btnDeleteCustomers').click(function (e) {
        e.preventDefault();
        var data = {};
        data.customerIds = $('tbody input[type=checkbox]:checked').map(function () {
            console.log($(this));
            return $(this).val();
        }).get();
        deleteCustomer(data);
    });

    const btnDeleteCustomer = (customerId) => {
        deleteCustomer({"customerIds": [customerId]});
    }

    const deleteCustomer = (data) => {
        $.ajax({
            type: "DELETE",
            url: "${customerAPI}" + data.customerIds,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "text",
            success: (response) => {
                alert(response);
                window.location.replace("/admin/customer-list");
            },
            error: (response) => {
                console.log("Xóa không thành công!");
                console.log(response);
            }
        });
    }

    $(`#btnSearchCustomer`).click(e => {
        e.preventDefault();
        $(`#listForm`).submit();
    })

</script>
</body>
</html>
