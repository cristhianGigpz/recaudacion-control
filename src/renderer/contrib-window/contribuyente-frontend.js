import { ipcRenderer } from "electron";
import UI from "./main-window/ui";
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery } from "../bd/index"
const ui = new UI();
/* const { Client, Pool } = require("pg");
require("custom-env").env("config");
const connection = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_BASEDATOS,
  password: process.env.DB_PASS,
  port: process.env.DB_PORT
}); */
/**
 * Carga todos los eventos al formulario
 */
window.addEventListener("DOMContentLoaded", () => {
  /* connection.connect(err => {
    if (err) return err;
  });
 */
  LoadData();
  closeRegistroContribuyente();
  register();
  ui.pasarFocus("form-contribuyente");
});

const closeRegistroContribuyente = () => {
  ui.closeFrom("reg-contribuyente-end");
  //connection.end();
};

const LoadData = () => {
  //const element = ui.loadGetData('departamento');
  //element.then((e)=>{LoaderData(e)})
  //cerrar formulario
  listGrilla();
  //ui.closeFrom("cancel-button");
};

/**
 * Lista los datos de la tabla
 */
const listGrilla = () => {
  //const dep = ui.loadGetData("contribuyente"); //CONECTA CON LA BD Y TRAE DATOS DE TABLA
  const dep = loadGetData("contribuyente");
  dep.then(e => {
    //LoaderData(e);
  });
};

const LoaderData = items => {
  let card = "";
  items.forEach(e => {
    card += `<tr>
                <td>${e.iddepartamento}</td>
                <td>${e.nombre_departamento}</td>
                <td>
                    <button id="${
                      e.iddepartamento
                    }" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                    <button id="${
                      e.iddepartamento
                    }" class="btn-crud" onclick="btnDelete(this)"><span class="icon icon-trash"></span></button>
                </td>
            </tr>`;
  });

  document.getElementById("load-dep").innerHTML = card;
};

const register = () => {
  document.getElementById("btn-guardar").addEventListener("click", e => {
    e.preventDefault();
    let cod = parseInt(document.getElementById("cod").value);

    let form = document.getElementById("form-contribuyente");
    let valuesForm = ui.valuesElements(form);
   ///alert(valuesForm);
    if (ui.validateForm(valuesForm)) {
    /*
    const query = 'INSERT INTO contribuyente(nombre_razon_social,tipodoc,numerodoc,idurb,direccion,numero,dpto,manzana,lote,telefono,tipo_persona,motivo,difimpuesto,observacion,totalanexo,estado,impuestoanual,valortotalexonerado,valortotalpredio,baseimponiblea) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20) RETURNING *'
    const params = [valuesForm[0], valuesForm[1], parseInt(valuesForm[2]), parseInt(valuesForm[3]), valuesForm[4], parseInt(valuesForm[9]), valuesForm[8], valuesForm[7], valuesForm[6], valuesForm[17], valuesForm[5], valuesForm[10], valuesForm[18], valuesForm[19], parseInt(valuesForm[11]), parseInt(valuesForm[12]), parseInt(valuesForm[13]), parseInt(valuesForm[14]), parseInt(valuesForm[15]), parseInt(valuesForm[16])] 
    */
    // promise
    /* connection
    .query(query, params)
    .then(res => {
      console.log(res.rows[0])
    })
    .catch(e => console.error(e.stack))
    alert('process !!') */
      let data = {
        nombre_razon_social: valuesForm[0],
        tipodoc: valuesForm[1],
        numerodoc: valuesForm[2],
        idurb: parseInt(valuesForm[3]),
        direccion: valuesForm[4],
        numero: parseInt(valuesForm[9]),
        dpto: valuesForm[8],
        manzana: valuesForm[7],
        lote: valuesForm[6],
        telefono: valuesForm[17],
        tipo_persona: valuesForm[5],
        motivo: valuesForm[10],
        difimpuesto: valuesForm[18],
        observacion: valuesForm[19],
        totalanexo: parseInt(valuesForm[11]),
        estado: parseInt(valuesForm[12]),
        impuestoanual: parseInt(valuesForm[13]),
        valortotalexonerado: parseInt(valuesForm[14]),
        valortotalpredio: parseInt(valuesForm[15]),
        baseimponiblea: parseInt(valuesForm[16])
      };
      
    const commanQuery =
      cod === 0
        ? createInsertQuery("contribuyente", data)
        : createUpdateQuery("contribuyente", data, "idcontribuyente", cod);
    
    const result = executeQuery(
      commanQuery.query,
      commanQuery.params,
      "contribuyente"
    );
    ui.clearElements(form)
    ui.initFocus(form)
    console.log('datos insertados !')
    //console.log(commanQuery.query)
    //console.log(commanQuery.params)
    //reload(result);
   }else {
    alert("inserte todos los datos !!!");
  }
    /*
    insert into contribuyente (nombre_razon_social,tipodoc,numerodoc,idurb,direccion,numero,dpto,manzana,lote,telefono,tipo_persona,motivo,difimpuesto,observacion,totalanexo,estado,impuestoanual,valortotalexonerado,valortotalpredio,baseimponiblea) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20)
contribuyente-frontend.js? [sm]:58 (20) ["CRISTHIAN JOEL ACEVEDO TIPIAN", "DNI", 44995954, 1, "JR. COMERCIO 121", 127, "ICA", "A", "1", "956314857", "NATURAL", "A", "40", "NINGUNA", 2, 1, 500, 200, 700, 700]
    */
  });
};

//clear en ui//
const reload = element => {
  element.then(e => {
    listGrilla();
    //clear();
  });
};
/**
 * Cancela la actualizacion de los datos
 */
const cancelUpdate = () => {
  document.getElementById("btn-cancelar").addEventListener("click", e => {
    e.preventDefault();
    document.getElementById("btn-cancelar").classList.add("u-none");
    //clear();
  });
};

