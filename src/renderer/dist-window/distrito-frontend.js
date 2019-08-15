import {ipcRenderer } from 'electron';
import UI from './main-window/ui'
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery, loadGetDataId, loadDataJoinDistrito } from "../bd/connect"
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
    const element = loadGetData('provincia');
    document.getElementById('selectProv').innerHTML +=`<option value='0'>seleccione distrito</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectProv').innerHTML += `<option value='${e.idprovincia}'>${e.nombre_provincia}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}

/**
 * Lista los datos de la tabla
 */
const listGrilla =()=>{
    const prov = loadDataJoinDistrito();
    prov.then((e)=>{LoaderData(e)})
}

/**
 * Registra y Actualiza los datos a la tablas
 */
const register =()=>{
    document.getElementById('btn-dist').addEventListener("click",(e)=>{
        e.preventDefault();
        let cod = parseInt(document.getElementById('cod').value);
        let prov =  document.getElementById('selectProv');
        let  strProv = prov.options[prov.selectedIndex].value;
        let dist = document.getElementById('dist').value;
        let codigo = document.getElementById('codigo').value;
        let abr = document.getElementById('abr').value;
        if(strProv === 0 ||  dist.length === 0 ||  codigo.length === 0 ||  abr.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        let data = {codigo:codigo , nomDistrito:dist,abreviatura:abr,idprovincia:strProv}
        const commanQuery = (cod === 0)
            ? createInsertQuery('distrito',data)
            : createUpdateQuery('distrito',data,'iddistrito',cod);
        const result = executeQuery(commanQuery.query,commanQuery.params,'distrito');
        reload(result);
        document.getElementById('btn-dist').innerText ="Guardar";
    })
}

/**
 * Limpia campo del formulario
 */
const clear =()=>{
    document.getElementById('selectProv').value = 0;
    document.getElementById('dist').value = '';
    document.getElementById('codigo').value = '';
    document.getElementById('abr').value = '';
    document.getElementById('cod').value = '0';
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
        document.getElementById('btn-dist').innerText ="Guardar";
        clear();
    })
}

/**
 * Elemento button atributo ID
 * @param {this} element 
 */
const btnEditar = (element)=>{
    const fullData = loadGetDataId('distrito','iddistrito',element.id);
    document.getElementById("btn-cancelar").classList.remove("u-none");
    fullData.then((items)=>{
        document.getElementById('btn-dist').innerText ="Actualizar";
        document.getElementById('cod').value = items[0].iddistrito;
        document.getElementById('dist').value= items[0].nomdistrito;
        document.getElementById('abr').value= items[0].abreviatura;
        document.getElementById('codigo').value= items[0].codigo;
        document.getElementById('selectProv').selectedIndex =items[0].idprovincia;
        //document.getElementById('selectDep').selectedIndex =items[0].iddepartamento;
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
    const commanQuery = createUpdateQuery('distrito',data,'iddistrito',id);
    ipcRenderer.on('MessageBox',(event,res)=>{
        //res = 0 -> eliminar el registro
        //res = 1 -> no elimina nada
        if(res === 0){
           const result = executeQuery(commanQuery.query,commanQuery.params,'distrito');
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
                <td>${e.iddistrito}</td>
                <td>${e.codigo}</td>
                <td>${e.nomdistrito}</td>
                <td>${e.abreviatura}</td>
                <td>${e.nombre_provincia}</td>
                <td>${e.nombre_departamento}</td>
                <td>
                    <button id="${e.iddistrito}" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                    <button id="${e.iddistrito}" class="btn-crud" onclick="btnDelete(this)"><span class="icon icon-trash"></span></button>
                </td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}