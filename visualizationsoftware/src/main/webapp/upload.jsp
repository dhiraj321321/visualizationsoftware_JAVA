<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.login.visualizationsoftware.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Data - DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; }
        .upload-area {
            border: 2px dashed #dee2e6;
            border-radius: .5rem;
            padding: 3rem;
            transition: border-color .15s ease-in-out, background-color .15s ease-in-out;
            cursor: pointer;
        }
        .upload-area.is-dragover {
            border-color: var(--bs-primary);
            background-color: var(--bs-primary-bg-subtle);
        }
        #fileInput { display: none; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp"><i class="bi bi-bar-chart-line-fill"></i> DataViz Pro</a>
        <div class="ms-auto">
             <a class="btn btn-outline-light btn-sm" href="dashboard.jsp"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-8">
            <div class="text-center mb-4">
                <h1 class="h2">Upload Your Data</h1>
                <p class="lead text-muted">Upload your CSV and tell us which columns to visualize.</p>
            </div>
            
            <form action="upload" method="post" enctype="multipart/form-data" id="uploadForm">
                <div class="accordion" id="uploadWizard">

                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#stepOne">
                                <strong>Step 1:</strong> &nbsp;Select Your CSV File
                            </button>
                        </h2>
                        <div id="stepOne" class="accordion-collapse collapse show" data-bs-parent="#uploadWizard">
                            <div class="accordion-body">
                                <label for="fileInput" id="uploadArea" class="upload-area text-center">
                                    <i class="bi bi-cloud-arrow-up-fill fs-1 text-primary"></i>
                                    <h5 class="mt-3">Drag & drop your file here</h5>
                                    <p class="text-muted mb-0">or click to browse</p>
                                </label>
                                <input type="file" id="fileInput" name="dataFile" accept=".csv" required>
                                <div id="fileInfo" class="mt-3 text-center d-none">
                                    <p class="mb-0"><i class="bi bi-file-earmark-check-fill text-success"></i> Selected file: <strong id="fileName"></strong></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#stepTwo" disabled>
                                <strong>Step 2:</strong> &nbsp;Map Columns and Set Options
                            </button>
                        </h2>
                        <div id="stepTwo" class="accordion-collapse collapse" data-bs-parent="#uploadWizard">
                            <div class="accordion-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="labelColumn" class="form-label fw-bold">Label Column (X-axis)</label>
                                        <select name="labelColumn" id="labelColumn" class="form-select" required></select>
                                        <div class="form-text">Select the column with text categories (e.g., 'Country', 'Product').</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="valueColumn" class="form-label fw-bold">Value Column (Y-axis)</label>
                                        <select name="valueColumn" id="valueColumn" class="form-select" required></select>
                                        <div class="form-text">Select the column with numbers to plot (e.g., 'Sales', 'Population').</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="limitCount" class="form-label fw-bold">Number of Categories to Show</label>
                                    <input type="number" name="limitCount" id="limitCount" class="form-control" min="1" max="100" value="10" required>
                                </div>
                                <h6 class="mt-4">Data Preview (First 5 Rows)</h6>
                                <div class="table-responsive" style="max-height: 200px;">
                                    <table class="table table-striped table-sm">
                                        <thead id="preview-head"></thead>
                                        <tbody id="preview-body"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="d-grid mt-4">
                     <button type="submit" class="btn btn-primary btn-lg" id="submitBtn" disabled>
                        Next: Choose Chart Type <i class="bi bi-arrow-right-circle-fill"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%-- THIS SCRIPT BLOCK IS UPDATED --%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('fileInput');
        const fileInfo = document.getElementById('fileInfo');
        const fileNameEl = document.getElementById('fileName');
        const submitBtn = document.getElementById('submitBtn');
        const step2_collapse = new bootstrap.Collapse(document.getElementById('stepTwo'), { toggle: false });
        const step2_button = document.querySelector('button[data-bs-target="#stepTwo"]');

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => uploadArea.addEventListener(eventName, preventDefaults, false));
        function preventDefaults(e) { e.preventDefault(); e.stopPropagation(); }
        ['dragenter', 'dragover'].forEach(eventName => uploadArea.addEventListener(eventName, () => uploadArea.classList.add('is-dragover'), false));
        ['dragleave', 'drop'].forEach(eventName => uploadArea.addEventListener(eventName, () => uploadArea.classList.remove('is-dragover'), false));
        
        uploadArea.addEventListener('drop', (e) => {
            fileInput.files = e.dataTransfer.files;
            handleFileSelect({ target: fileInput });
        }, false);
        fileInput.addEventListener('change', handleFileSelect, false);

        function handleFileSelect(event) {
            const file = event.target.files[0];
            if (!file || !file.name.endsWith('.csv')) {
                alert('Please select a valid CSV file.');
                fileInput.value = ''; // Reset file input
                return;
            }

            fileNameEl.textContent = file.name;
            fileInfo.classList.remove('d-none');
            
            const reader = new FileReader();
            reader.onload = function (e) {
                const lines = e.target.result.split(/\\r\\n|\\n|\\r/);
                if (lines.length > 0) {
                    const headers = lines[0].split(",").map(h => h.trim().replace(/^"|"$/g, ''));
                    populateSelects(headers);
                    populatePreview(headers, lines.slice(1, 6));

                    step2_button.disabled = false;
                    submitBtn.disabled = false;
                    step2_collapse.show();
                }
            };
            reader.readAsText(file);
        }

        function populateSelects(headers) {
            const labelSelect = document.getElementById("labelColumn");
            const valueSelect = document.getElementById("valueColumn");
            labelSelect.innerHTML = "";
            valueSelect.innerHTML = "";
            headers.forEach((header, index) => {
                labelSelect.add(new Option(header, index));
                valueSelect.add(new Option(header, index));
            });
            if(headers.length > 1) valueSelect.selectedIndex = 1;
        }

        // THIS FUNCTION IS NOW MORE ROBUST
        function populatePreview(headers, dataRows) {
            const thead = document.getElementById('preview-head');
            const tbody = document.getElementById('preview-body');
            thead.innerHTML = '';
            tbody.innerHTML = '';

            let headerRowHtml = '<tr>';
            headers.forEach(h => headerRowHtml += `<th>${h}</th>`);
            headerRowHtml += '</tr>';
            thead.innerHTML = headerRowHtml;

            for (const rowStr of dataRows) {
                if (!rowStr || rowStr.trim() === '') continue; // Safely skip empty or null rows

                const cells = rowStr.split(',');
                let bodyRowHtml = '<tr>';
                for (const cell of cells) {
                    // Check if cell is a string before calling string methods
                    const cellText = (typeof cell === 'string') 
                        ? cell.trim().replace(/^"|"$/g, '') 
                        : ''; // Use empty string for non-string cells
                    bodyRowHtml += `<td>${cellText}</td>`;
                }
                bodyRowHtml += '</tr>';
                tbody.innerHTML += bodyRowHtml;
            }
        }
    });
</script>

</body>
</html>