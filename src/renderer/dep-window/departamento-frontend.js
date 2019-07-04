import { remote, ipcRenderer } from 'electron'
import settings from 'electron-settings'
import crypto from 'crypto'
import { createConnection } from 'net';
//import UI from './UI';
const { Client, Pool } = require('pg')
require('custom-env').env('config')
/**
 * Load Events
 */
window.addEventListener('DOMContentLoaded',()=>{
    
    /*const ui = new UI();
    ui.LoadData();*/
    NewDdata();
    SaveButton();
    EditButton();
    CancelButton();
    LoadData();
});

/**
 * Connection BD
 */
const connection = new Client({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database:  process.env.DB_BASEDATOS,
    password: process.env.DB_PASS,
    port: process.env.DB_PORT
});

/**
 * Listado de Departamento
 */
const LoadData =()=>{
    connection.connect((err)=>{
        if (err) console.log(err)
    });
    connection.query('SELECT * FROM departamento')
    .then((res) =>{
        const ListDepartamento = res.rows.length > 0 ? res.rows : [];
        LoaderData(ListDepartamento);
        ipcRenderer.send('connectionDepartamento', ListDepartamento);
       // connection.end();
    })
    .catch(e => console.log(e));
}

/**
 * Close Modal
 */
const CancelButton =()=>{
    document.getElementById('cancel-button').addEventListener('click',()=>{
        const prefsWindow = remote.getCurrentWindow()
        prefsWindow.close()
    })
}

const SaveButton =()=>{
    document.getElementById('btn-guardar').addEventListener('click',(e)=>{
        e.preventDefault();
        const _name = document.getElementById('dep').value;

        const query = {
            text: 'INSERT INTO departamento(nombre_departamento) VALUES($1) RETURNING *',
            values: [_name],
        }
        connection.query(query)
        .then(res => {
            document.getElementById('dep').value='';
            LoadData();
            const el = document.getElementById('succes');
            el.className = 'dog';
            setInterval(function(){ el.className = 'succes'; }, 3000);
        })
        .catch(e => console.log(e.stack))
    })
}
/*
const EditButton =()=>{
    document.getElementById('edit').addEventListener('click',(e)=>{
        e.preventDefault();
       
       alert('data para editar')
    })
}*/
const NewDdata =()=>{
    document.getElementById('new-data').addEventListener('click',()=>{
       alert('nuevo');
    })
}
const EditButton =()=>{
    let el = document.createElement('button');
    el.id='edit';
    el.innerHTML =`<span class="icon icon-pencil"></span>`;
    el.addEventListener('click',()=>{
        alert('click')
    });
    /*document.body.appendChild(el);*/

    //return el.outerHTML;
    return el;
}
/**
 * 
 * @param {matriz departamento} items 
 */
const LoaderData=(items)=>{
    let card = '';
    items.forEach((e)=>{
        card +=`<tr>
                <td>${e.iddepartamento}</td>
                <td>${e.nombre_departamento}</td>
                <td id="list">
                    ${EditButton()}
                    <button id="remove"><span class="icon icon-cancel"></span></button>
                </td>
            </tr>`;
    });
    document.getElementById("load-dep").innerHTML = card;
}