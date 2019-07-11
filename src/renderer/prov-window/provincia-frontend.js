import UI from './main-window/ui'
const ui = new UI();
window.addEventListener('DOMContentLoaded',()=>{
    LoadData();
    register();
});
const LoadData =()=>{
    const element = ui.loadGetData('departamento');
    document.getElementById('selectDep').innerHTML +=`<option value='0'>seleccione departamento</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectDep').innerHTML += `<option value='${e.iddepartamento}'>${e.nombre_departamento}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}
const listGrilla =()=>{
    const prov = ui.loadDataJoin();
    prov.then((e)=>{LoaderData(e)})
}
const register =()=>{
    document.getElementById("btn-prov").addEventListener("click",(e)=>{
        e.preventDefault();
        let dep =  document.getElementById('selectDep');
        let  strDep = dep.options[dep.selectedIndex].value;
        let prov = document.getElementById('prov').value;
        if(strDep === 0 ||  prov.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        const element = ui.insertData('INSERT INTO provincia(nombre_provincia,idDepartamento) VALUES($1,$2);',[prov,strDep],'provincia');
        element.then((e)=>{
            listGrilla();
            document.getElementById('selectDep').value = 0;
            document.getElementById('prov').value = '';
        });

    });
}
const LoaderData=(items)=>{
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.idprovincia}</td>
                <td>${e.nombre_provincia}</td>
                <td>${e.nombre_departamento}</td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}