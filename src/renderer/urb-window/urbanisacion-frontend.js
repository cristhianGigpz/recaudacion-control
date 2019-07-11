import UI from './main-window/ui'
const ui = new UI();
window.addEventListener('DOMContentLoaded',()=>{
    LoadData();
    register();
});
const LoadData =()=>{
    const element = ui.loadGetData('distrito');
    document.getElementById('selectDist').innerHTML +=`<option value='0'>seleccione distrito</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectDist').innerHTML += `<option value='${e.iddistrito}'>${e.nomdistrito}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}
const register =()=>{
    document.getElementById('btn-urb').addEventListener("click",(e)=>{
        e.preventDefault();
        let dist =  document.getElementById('selectDist');
        let  strDist = dist.options[dist.selectedIndex].value;
        let urb = document.getElementById('urb').value;
        let cod = document.getElementById('cod').value;
        let abr = document.getElementById('abreviatura').value;
        if(strDist === 0 ||  strDist.length === 0 ||  urb.length === 0 ||  cod.length === 0 ||  abreviatura.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        const element = ui.insertData('INSERT INTO urbanisacion(codigo,nomUrbanisacion,abreviatura,idDistrito) VALUES($1,$2,$3,$4);',[cod,urb,abr,strDist],'distrito');
        element.then((e)=>{
            listGrilla();
            document.getElementById('selectDist').value = 0;
            document.getElementById('urb').value = '';
            document.getElementById('cod').value = '';
            document.getElementById('abreviatura').value = '';
        });
    })
}
const listGrilla =()=>{
    const prov = ui.loadDataJoinUbanisacion();
    prov.then((e)=>{LoaderData(e)})
}
const LoaderData=(items)=>{
    console.log(items);
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.idurb}</td>
                <td>${e.codigo}</td>
                <td>${e.nomurbanisacion}</td>
                <td>${e.abreviatura}</td>
                <td>${e.nomdistrito}</td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}