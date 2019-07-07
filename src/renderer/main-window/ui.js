import { remote, ipcRenderer } from 'electron';
import { openWindow } from './ipcRendererEvents';
const { Client, Pool } = require('pg')
require('custom-env').env('config')
class UI{
    connection (){
        const connection = new Client({
            user: process.env.DB_USER,
            host: process.env.DB_HOST,
            database:  process.env.DB_BASEDATOS,
            password: process.env.DB_PASS,
            port: process.env.DB_PORT
        });
        return connection;
    }

    /**
     * función para listar los datos de las tablas
     * @param {nombre table} table 
     */
    async loadGetData(table){
        connection.connect((err)=>{
            if(err) return err;
        });
        const listData = connection.query(`SELECT * FROM ${table}`)
        .then((res) =>{
            const loadData = res.rows.length > 0 ? res.rows : [];
            return  loadData;
        })
        .catch(e => console.log(e));

        return await listData;
    }

    /**
     * función para registrar data a la BD
     * @param {sentencia sql} _query 
     * @param {valores agregar} value 
     * @param {tabla para el reload de data} table 
     */
    async insertData(_query,value,table){
        const query ={
            text: _query,
            values:value
        }
        const data = connection.query(query)
        .then(res =>{
            return this.loadGetData(table)
        })
        return await data;
    }


    /**
     * función cierra formulario
     * @param {id button} idBtn 
     */
    closeFrom(idBtn){
        const btn = document.getElementById(idBtn);
        if(btn){
            btn.addEventListener('click',(e)=>{
                const prefsWindow = remote.getCurrentWindow()
                prefsWindow.close()
            })
        }
    }

    /**
     * función abre una ventana llamada desde un boton del formulario
     * @param {id button} element 
     * @param {width} ancho 
     * @param {hight} alto 
     * @param {title from} title 
     * @param {nombre from} file 
     */
    openWindows(element,ancho,alto,title,file){
        const btn =document.getElementById(element);
        if(btn){
            btn.addEventListener('click',(e)=>{
                e.preventDefault();
                openWindow(ancho, alto, title, true, file);
            })
        }
    }
}
export default UI;