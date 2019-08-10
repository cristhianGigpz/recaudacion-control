import { ipcRenderer } from "electron";
import UI from "./main-window/ui";
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
});

const closeRegistroContribuyente = () => {
  ui.closeFrom("reg-contribuyente-end");
  ui.closeFrom("btn-close");
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
  const dep = ui.loadGetData("contribuyente");
  dep.then(e => {
    //LoaderData(e);
  });
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
        numerodoc: parseInt(valuesForm[2]),
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
        ? ui.createInsertQuery("contribuyente", data)
        : ui.createUpdateQuery("contribuyente", data, "idcontribuyente", cod);
    
    const result = ui.executeQuery(
      commanQuery.query,
      commanQuery.params,
      "contribuyente"
    );
    console.log(result)
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

const clear = () => {
  document.getElementById("cod").value = "0";
  document.getElementById("nombre_razon").value = "";
  document.getElementById("selectDoc").value = 0;
  document.getElementById("numero_doc").value = "";
  document.getElementById("selectUrba").value = 0;
  document.getElementById("direccion").value = "";
  document.getElementById("lote").value = "";
  document.getElementById("manzana").value = "";
  document.getElementById("departamento").value = "";
  document.getElementById("numero").value = "";
  document.getElementById("total_anexo").value = "";
  document.getElementById("impuesto_anual").value = "";
  document.getElementById("total_exonerado").value = "";
  document.getElementById("total_predio").value = "";
  document.getElementById("base_imponible").value = "";
  document.getElementById("observacion").value = "";
  document.getElementById("telefono").value = "";
  document.getElementsByName("rbTipoPersona").checked = false;
  document.getElementsByName("rbMotivo").checked = false;
  document.getElementById("checkEstado").checked = 0;
};
