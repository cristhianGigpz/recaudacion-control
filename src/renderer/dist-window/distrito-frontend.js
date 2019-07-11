import UI from './main-window/ui'
const ui = new UI();
window.addEventListener('DOMContentLoaded',()=>{
    LoadData();
    register();
});
const LoadData =()=>{
    const element = ui.loadGetData('provincia');
    document.getElementById('selectProv').innerHTML +=`<option value='0'>seleccione distrito</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectProv').innerHTML += `<option value='${e.idprovincia}'>${e.nombre_provincia}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}
const listGrilla =()=>{
    const prov = ui.loadDataJoinDistrito();
    prov.then((e)=>{LoaderData(e)})
}
const register =()=>{
    document.getElementById('btn-dist').addEventListener("click",(e)=>{
        e.preventDefault();
        let prov =  document.getElementById('selectProv');
        let  strProv = prov.options[prov.selectedIndex].value;
        let dist = document.getElementById('dist').value;
        let codigo = document.getElementById('codigo').value;
        let abr = document.getElementById('abr').value;
        if(strProv === 0 ||  dist.length === 0 ||  codigo.length === 0 ||  abr.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        const element = ui.insertData('INSERT INTO distrito(codigo,nomDistrito,abreviatura,idprovincia) VALUES($1,$2,$3,$4);',[codigo,dist,abr,strProv],'distrito');
        element.then((e)=>{
            listGrilla();
            document.getElementById('selectProv').value = 0;
            document.getElementById('dist').value = '';
            document.getElementById('codigo').value = '';
            document.getElementById('abr').value = '';
        });
    })
}
const LoaderData=(items)=>{
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.iddistrito}</td>
                <td>${e.codigo}</td>
                <td>${e.nomdistrito}</td>
                <td>${e.abreviatura}</td>
                <td>${e.nombre_provincia}</td>
                <td>${e.nombre_departamento}</td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}