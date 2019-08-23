import {ipcRenderer } from 'electron';
import UI from './main-window/ui'
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery, loadGetDataId, loadDataJoinUbanisacion } from "../bd/connect"
const ui = new UI();
/**
 * Carga todos los eventos al formulario
 */
window.addEventListener('DOMContentLoaded',()=>{
    LoadData();
    register();
    cancelUpdate();
});

/**
 * Inicializa los datos en el formulario
 */
const LoadData =()=>{
    const element = loadGetData('distrito');
    document.getElementById('selectDist').innerHTML +=`<option value='0'>seleccione distrito</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectDist').innerHTML += `<option value='${e.iddistrito}'>${e.nomdistrito}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}

/**
 * Lista los datos de la tabla
 */
const listGrilla =()=>{
    const prov = loadDataJoinUbanisacion();
    prov.then((e)=>{LoaderData(e)})
}

/**
 * Registra y Actualiza los datos a la tablas
 */
const register =()=>{
    document.getElementById('btn-urb').addEventListener("click",(e)=>{
        e.preventDefault();
        let dist =  document.getElementById('selectDist');
        let  strDist = dist.options[dist.selectedIndex].value;
        let urb = document.getElementById('urb').value;
        let cod = document.getElementById('cod').value;
        let abr = document.getElementById('abreviatura').value;
        let id = parseInt(document.getElementById('id').value);
        if(strDist === 0 ||  strDist.length === 0 ||  urb.length === 0 ||  cod.length === 0 ||  abreviatura.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        let data = {codigo:cod , nomUrbanisacion:urb,abreviatura:abr,idDistrito:strDist}
        const commanQuery = (id === 0) 
            ? createInsertQuery('urbanisacion',data) 
            : createUpdateQuery('urbanisacion',data,'idurb',id);
        const result = executeQuery(commanQuery.query,commanQuery.params,'urbanisacion');
        reload(result);
        document.getElementById('btn-urb').innerText ="Guardar";

    })
}
/**
 * Limpia campo del formulario
 */
const clear =()=>{
    document.getElementById('selectDist').value = 0;
    document.getElementById('urb').value = '';
    document.getElementById('cod').value = '';
    document.getElementById('abreviatura').value = '';
    document.getElementById('id').value = '0';
}

/**
 * Recarga la grilla
 * @param {Matriz de datos} element 
 */
const reload =(element)=>{
    element.then((e)=>{
        listGrilla();
        clear();
    });
}

/**
 * Cancela la actualizacion de los datos
 */
const cancelUpdate=()=>{
    document.getElementById("btn-cancelar").addEventListener("click",(e)=>{
        e.preventDefault();
        document.getElementById("btn-cancelar").classList.add('u-none');
        clear();
        document.getElementById('btn-urb').innerText ="Guardar";
    })
}

/**
 * Elemento button atributo ID
 * @param {this} element 
 */
const btnEditar = (element)=>{
    const fullData = loadGetDataId('urbanisacion','idurbanisacion',element.id);
    document.getElementById("btn-cancelar").classList.remove("u-none");
    fullData.then((items)=>{
        document.getElementById('btn-urb').innerText ="Actualizar";
        document.getElementById('id').value = items[0].idurbanisacion;
        document.getElementById('selectDist').selectedIndex = items[0].iddistrito;
        document.getElementById('urb').value = items[0].nomurbanisacion;
        document.getElementById('abreviatura').value = items[0].abreviatura;
        document.getElementById('cod').value = items[0].codigo;
    })
}

/**
 * Elemento button atributo ID
 * @param {this} element 
 */
const btnDelete = (element)=>{
    let id = element.id;
    let options  = {
        title:"Eliminar Registro",
        buttons: ["Si","No"],
        message: "Eliminar Registro?",
        detail: 'Al eliminar no se puede recuperar',
        type : "question",
       }
    ui.showDialog(options);
    let data = {estado: '0'}
    const commanQuery = createUpdateQuery('urbanisacion',data,'idurb',id);
    ipcRenderer.on('MessageBox',(event,res)=>{
        //res = 0 -> eliminar el registro
        //res = 1 -> no elimina nada
        if(res === 0){
            const result = executeQuery(commanQuery.query,commanQuery.params,'urbanisacion');
            reload(result);
        }
    });
}

/**
 * Lista todos los datos para presentar en la grilla
 * @param {Matriz de Datos} items 
 */
const LoaderData=(items)=>{
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.idurb}</td>
                <td>${e.codigo}</td>
                <td>${e.nomurbanisacion}</td>
                <td>${e.abreviatura}</td>
                <td>${e.nomdistrito}</td>
                <td>
                    <button id="${e.idurb}" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                    <button id="${e.idurb}" class="btn-crud" onclick="btnDelete(this)"><span class="icon icon-trash"></span></button>
                </td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}