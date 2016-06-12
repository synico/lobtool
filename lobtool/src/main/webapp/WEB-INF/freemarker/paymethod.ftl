<html>
<head>
	<link rel="stylesheet" href="../resources/javascript/dojo/resources/dojo.css" >
	<link rel="stylesheet" href="../resources/javascript/dgrid/css/dgrid.css" >
	<link rel="stylesheet" href="../resources/javascript/dgrid/css/skins/claro.css" >
</head>
<body class="claro">
	<div id="grid"></div>
	<script src="../resources/javascript/dojoConfig.js"></script>
	<script src="../resources/javascript/dojo/dojo.js"></script>
	
	<script>
		require(['dgrid/Grid', 'dojo/domReady!'], function(Grid) {
			var data = [
				<#list payMethods as pm>
					{ payMethodId: '${pm.payMethodId}', code: '${pm.code}', name: '${pm.name}', isSystem: '${pm.isSystem}', isMobile: '${pm.isMobile}', isHaveChange: '${pm.isHaveChange}'},
				</#list>
			];
			var grid = new Grid({
				columns: {
					payMethodId: '֧����ʽID',
					code: '֧������',
					name: '֧����ʽ����',
					isSystem: 'ϵͳ',
					isMobile: '�ƶ�',
					isHaveChange: '���'
				}
			}, 'grid');
			grid.renderArray(data);
		});
	</script>
	
</body>
</html>