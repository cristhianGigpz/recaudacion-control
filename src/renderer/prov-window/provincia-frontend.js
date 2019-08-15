import {ipcRenderer } from 'electron';
import UI from './main-window/ui'
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery, loadGetDataId, loadDataJoin } from "../bd/connect"
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
    const element = loadGetData('departamento');
    document.getElementById('selectDep').innerHTML +=`<option value='0'>seleccione departamento</option>`;
    element.then((items)=>{
        items.forEach(e => {
            document.getElementById('selectDep').innerHTML += `<option value='${e.iddepartamento}'>${e.nombre_departamento}</option>`;
        });
    });
    listGrilla();
    ui.closeFrom('cancel-button');
}

/**
 * Lista los datos de la tabla
 */
const listGrilla =()=>{
    const prov = loadDataJoin();
    prov.then((e)=>{LoaderData(e)})
}

/**
 * Registra y Actualiza los datos a la tablas
 */
const register =()=>{
    document.getElementById("btn-prov").addEventListener("click",(e)=>{
        e.preventDefault();
        let dep =  document.getElementById('selectDep');
        let  strDep = dep.options[dep.selectedIndex].value;
        let cod = parseInt(document.getElementById('cod').value);
        let prov = document.getElementById('prov').value;
        if(strDep === 0 ||  prov.length === 0){
            alert("llene toda la informacion");
            return false;
        }
        let data = {nombre_provincia:prov , idDepartamento:strDep}
        const commanQuery = (cod === 0) 
            ? createInsertQuery('provincia',data) 
            : createUpdateQuery('provincia',data,'idprovincia',cod);
        const result = executeQuery(commanQuery.query,commanQuery.params,'provincia');
        reload(result);
    });
}

/**
 * Limpia campo del formulario
 */
const clear =()=>{
    document.getElementById('selectDep').value = 0;
    document.getElementById('prov').value = '';
    document.getElementById("btn-cancelar").classList.add('u-none');
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
        clear();
    })
}

/**
 * Elemento button atributo ID
 * @param {this} element 
 */
const btnEditar = (element)=>{
    const fullData = loadGetDataId('provincia','idprovincia',element.id);
    document.getElementById("btn-cancelar").classList.remove("u-none");
    fullData.then((items)=>{
        document.getElementById('cod').value = items[0].idprovincia;
        document.getElementById('btn-prov').innerText ="Actualizar";
        document.getElementById('prov').value= items[0].nombre_provincia;
        document.getElementById('selectDep').selectedIndex =items[0].iddepartamento;
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
    const commanQuery = createUpdateQuery('provincia',data,'idprovincia',id);
    ipcRenderer.on('MessageBox',(event,res)=>{
        //res = 0 -> eliminar el registro
        //res = 1 -> no elimina nada
        if(res === 0){
           const result = executeQuery(commanQuery.query,commanQuery.params,'provincia');
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
                <td>${e.idprovincia}</td>
                <td>${e.nombre_provincia}</td>
                <td>${e.nombre_departamento}</td>
                <td>
                    <button id="${e.idprovincia}" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                    <button id="${e.idprovincia}" class="btn-crud" onclick="btnDelete(this)"><span class="icon icon-trash"></span></button>
                </td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}

/*
document.getElementById('btn-sql').addEventListener("click",(e)=>{
        e.preventDefault();
        loadSql(['distrito','provincia','departamento'],['idprovincia','iddepartamento']);
    })
const loadSql =(table,ids)=>{
    let join ='';
    for (let index = 0; index < table.length; index++){
        if(index === 0){
            join +=`select * from ${table[index]} t${index} `;
        }else{
            join +=` inner join ${table[index]} t${index}`;
        }
    }
    console.log(`${join}`);
}*/