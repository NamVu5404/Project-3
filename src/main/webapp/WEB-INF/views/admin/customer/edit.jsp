<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="customerEditUrl" value="/admin/customer-edit"/>
<c:url var="customerAPI" value="/api/customers/"/>
<c:url var="transactionAPI" value="/api/transactions/"/>
<html>
<head>
    <title>Thông tin khách hàng</title>
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
                <h1>Thông tin khách hàng</h1>
            </div><!-- /.page-header -->

            <div class="row">
                <form:form modelAttribute="model" action="${customerEditUrl}" method="GET" id="editForm">
                    <div class="col-xs-12">
                        <form class="form-horizontal" role="form" style="font-family: 'Times New Roman', Times, serif;">
                            <div class="form-group hidden">
                                <label class="col-xs-3">ID khách hàng</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="id"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tên khách hàng</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="fullName"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Số điện thoại</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="phone"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Email</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="email"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tên công ty</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="companyName"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Nhu cầu</label>

                                <div class="col-sm-9">
                                    <form:input class="col-xs-9" type="text" path="demand"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tình trạng</label>

                                <div class="col-xs-4">
                                    <form:select class="form-control" path="status" items="${status}">
                                        <form:option value="" label="---Chọn tình trạng---"/>
                                    </form:select>
                                </div>
                            </div>

                            <div class="form-group" style="margin-bottom: 100px">
                                <label class="col-xs-3"></label>

                                <div class="col-sm-9">
                                    <c:if test="${empty model.id}">
                                        <button type="button" class="btn btn-sm btn-primary"
                                                id="btnAddOrUpdateCustomer">
                                            Thêm khách hàng
                                        </button>
                                    </c:if>

                                    <security:authorize access="hasRole('MANAGER')">
                                        <c:if test="${not empty model.id}">
                                            <button type="button" class="btn btn-sm btn-warning"
                                                    id="btnAddOrUpdateCustomer">
                                                Sửa thông tin
                                            </button>
                                        </c:if>
                                    </security:authorize>

                                    <a href="/admin/customer-list">
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

    <%--Transaction Type--%>
    <c:forEach var="item" items="${transactionType}">
        <div class="col-xs-12">
            <div class="col-sm-12">
                <h3 class="header smaller lighter blue">${item.value}</h3>
                <button class="btn btn-lg btn-primary" onclick="transactionType('${item.key}', ${model.id})">
                    <i class="orange ace-icon fa fa-location-arrow bigger-130"></i>Add
                </button>
            </div>
            <c:if test="${item.key == 'CSKH'}">
                <div class="col-xs-12">
                    <table id="simple-table" class="table table-striped table-bordered table-hover">
                        <thead></thead>
                        <tbody>
                        <form:form modelAttribute="transactionListCSKH" method="get">
                            <display:table name="transactionListCSKH" cellspacing="0" cellpadding="0"
                                           sort="external"
                                           defaultsort="2" defaultorder="ascending"
                                           id="tableList"
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
                                <display:column headerClass="text-left" property="createdDate" title="Ngày tạo"/>
                                <display:column headerClass="text-left" property="createdBy" title="Người tạo"/>
                                <display:column headerClass="text-left" property="modifiedDate" title="Ngày sửa"/>
                                <display:column headerClass="text-left" property="modifiedBy" title="Người sửa"/>
                                <display:column headerClass="text-left" property="note" title="Chi tiết giao dịch"/>
                                <display:column headerClass="col-actions" title="Thao tác">
                                    <a class="btn btn-xs btn-info" title="Sửa thông tin giao dịch"
                                       onclick="UpdateTransaction(${tableList.id}, ${model.id}, '${item.key}')">
                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                    </a>
                                </display:column>
                            </display:table>
                        </form:form>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${item.key == 'DDX'}">
                <div class="col-xs-12">
                    <table id="simple-table" class="table table-striped table-bordered table-hover">
                        <thead></thead>
                        <tbody>
                        <form:form modelAttribute="transactionListDDX">
                            <display:table name="transactionListDDX" cellspacing="0" cellpadding="0"
                                           sort="external"
                                           defaultsort="2" defaultorder="ascending"
                                           id="tableList"
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
                                <display:column headerClass="text-left" property="createdDate" title="Ngày tạo"/>
                                <display:column headerClass="text-left" property="createdBy" title="Người tạo"/>
                                <display:column headerClass="text-left" property="modifiedDate" title="Ngày sửa"/>
                                <display:column headerClass="text-left" property="modifiedBy" title="Người sửa"/>
                                <display:column headerClass="text-left" property="note" title="Chi tiết giao dịch"/>
                                <display:column headerClass="col-actions" title="Thao tác">
                                    <a class="btn btn-xs btn-info" title="Sửa thông tin giao dịch"
                                       onclick="UpdateTransaction(${tableList.id}, ${model.id}, '${item.key}')">
                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                    </a>
                                </display:column>
                            </display:table>
                        </form:form>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </c:forEach>
    <%--End Transaction Type--%>
</div><!-- /.main-content -->

<%--Modal--%>
<div class="modal fade" id="transactionTypeModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nhập giao dịch</h4>
            </div>
            <div class="modal-body">
                <div class="form-group has-success">
                    <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">Chi tiết
                        giao dịch</label>
                    <div class="col-xs-12 col-sm-9">
                        <span class="block input-icon input-icon-right">
                            <input type="text" id="transactionDetail" class="width-100">
                        </span>
                    </div>
                </div>

                <input type="hidden" id="customerId" name="customerId" value="">
                <input type="hidden" id="code" name="code" value="">
                <input type="hidden" id="transactionId" name="id" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAddOrUpdateTransaction">Thêm giao dịch</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<%--End Modal--%>

<script>
    const transactionType = (code, customerId) => {
        $('#transactionTypeModal').modal();
        $('#customerId').val(customerId);
        $('#transactionDetail').val("");
        $('#transactionId').val("");
        $('#code').val(code);
    }

    const UpdateTransaction = (transactionId, customerId, code) => {
        $('#transactionTypeModal').modal();
        $('#transactionId').val(transactionId);
        $('#customerId').val(customerId);
        $('#code').val(code);
        loadTransactionDetail(transactionId, customerId);
    }

    const loadTransactionDetail = (transactionId, customerId) => {
        $.ajax({
            type: "GET",
            url: "${transactionAPI}" + transactionId,
            dataType: "JSON",
            success: function (response) {
                $('#transactionDetail').val(response.note);
            },
            error: () => {
                alert("error");
                window.location.href = "/admin/customer-edit-" + customerId + "?message=error";
            }
        })
    }

    $('#btnAddOrUpdateTransaction').click(function (e) {
        e.preventDefault();
        var data = {};
        data['id'] = $('#transactionId').val();
        data['customerId'] = $('#customerId').val();
        data['code'] = $('#code').val();
        data['note'] = $('#transactionDetail').val();
        addTransaction(data);
    });

    const addTransaction = (data) => {
        $.ajax({
            type: "POST",
            url: "${transactionAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: () => {
                console.log("success");
                alert("Thêm giao dịch thành công!");
                window.location.replace("/admin/customer-edit-" + data.customerId);
            },
            error: () => {
                alert("error");
                window.location.href = "/admin/customer-edit-" + data.customerId + "?message=error";
            }
        })
    }

    $(`#btnAddOrUpdateCustomer`).click(() => {
        var data = {};
        var formData = $('#editForm').serializeArray();
        $.each(formData, (_, item) => {
            data["" + item.name + ""] = item.value;
        })

        if (!data.fullName || data.fullName.trim().length === 0) {
            return alert("Tên không được thiếu");
        } else if (!data.phone || data.phone.trim().length === 0) {
            return alert("SĐT không được thiếu")
        } else if (!data.status || data.status.trim().length === 0) {
            return alert("Trạng thái không được thiếu");
        } else {
            addOrUpdateCustomer(data);
        }
    })

    const addOrUpdateCustomer = (data) => {
        $.ajax({
            type: "POST",
            url: "${customerAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: (response) => {
                alert(response);
                window.location.replace("/admin/customer-list");
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
