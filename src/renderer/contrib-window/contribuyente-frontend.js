import UI from "./main-window/ui";
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery } from "../bd/connect"
const ui = new UI();
/*
 * Carga todos los eventos al formulario
 */
window.addEventListener("DOMContentLoaded", () => {
  LoadData();
  cancelButton();
  register();
  ui.pasarFocus("form-contribuyente");
  cancelUpdate();
});

const cancelButton = () => {
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
    LoaderData(e);
  });
};

const LoaderData = items => {
  let card = "";
  items.forEach(e => {
    card += `<tr>
                <td>${e.nombre_razon_social}</td>
                <td>${e.tipodoc}</td>
                <td>${e.numerodoc}</td>
                <td>${e.direccion}</td>
                <td>${e.telefono}</td>
                <td>
                    <button id="${
                      e.idpartida
                    }" class="btn-crud" onclick="btnEditar(this)"><span class="icon icon-pencil"></span></button>
                    <button id="${
                      e.idpartida
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
    //console.log('datos insertados !')
    reload(result);
   }else {
    alert("inserte todos los datos !!!");
  }
    /*
    insert into contribuyente (nombre_razon_social,tipodoc,numerodoc,idurb,direccion,numero,dpto,manzana,lote,telefono,tipo_persona,motivo,difimpuesto,observacion,totalanexo,estado,impuestoanual,valortotalexonerado,valortotalpredio,baseimponiblea) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20)
contribuyente-frontend.js? [sm]:58 (20) ["CRISTHIAN JOEL ACEVEDO TIPIAN", "DNI", 44995954, 1, "JR. COMERCIO 121", 127, "ICA", "A", "1", "956314857", "NATURAL", "A", "40", "NINGUNA", 2, 1, 500, 200, 700, 700]
    */
  });
};

const initSave = () => {
  document.getElementById("cod").value = "0";
  document.getElementById("btn-cancelar").classList.add("u-none");
  document.getElementById("btn-guardar").innerText = "Guardar";
};

const reload = element => {
  element.then(e => {
    listGrilla();
    initSave();
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

const btnEditar = element => {
  const fullData = loadGetDataId(
    "contribuyente",
    "idcontribuyente",
    element.id
  );
  document.getElementById("btn-cancelar").classList.remove("u-none");
  fullData.then(items => {
    document.getElementById("cod").value = items[0].idcontribuyente;
    document.getElementById("codigop").value = items[0].codigo_presupuestal;
    document.getElementById("concepto").value = items[0].concepto;
    document.getElementById("importe").value = items[0].importe_tupa;
    document.getElementById("desct").value = items[0].desc_tupa;
    document.getElementById("periodo").value = items[0].idperiodo;
    document.getElementById("btn-guardar").innerText = "Actualizar";
  });
};

const btnDelete = element => {
  let id = element.id;
  let options = {
    title: "Eliminar Registro",
    buttons: ["Si", "No"],
    message: "Eliminar Registro?",
    detail: "Al eliminar no se puede recuperar",
    type: "question"
  };
  ui.showDialog(options);
  let data = { estado: "0" };
  const commanQuery = createUpdateQuery(
    "contribuyente",
    data,
    "idcontribuyente",
    id
  );
  ipcRenderer.on("MessageBox", (event, res) => {
    //res = 0 -> eliminar el registro
    //res = 1 -> no elimina nada
    if (res === 0) {
      const result = executeQuery(
        commanQuery.query,
        commanQuery.params,
        "contribuyente"
      );
      reload(result);
    }
  });
};

