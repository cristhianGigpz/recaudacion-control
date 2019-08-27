import { remote } from 'electron'
import UI from "./main-window/ui";
import { loadGetData, executeQuery, createInsertQuery, createUpdateQuery, loadGetDataId, disconnect } from "../bd/connect"
const ui = new UI();

/************************************************************** */

window.addEventListener("DOMContentLoaded", () => {
  LoadData();
  cancelButton();
  register();
  ui.pasarFocus("form-partida");
  cancelUpdate()
});

window.addEventListener("beforeunload", function (event) {
  disconnect();
});

const cancelButton = () => {
  ui.closeFrom("cancel-button");
  
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
  const dep = loadGetData("partidapresupuestal");
  dep.then(e => {
    LoaderData(e);
  });
};

const LoaderData = items => {
  let card = "";
  items.forEach(e => {
    card += `<tr>
                <td>${e.codigo_presupuestal}</td>
                <td>${e.concepto}</td>
                <td>${e.importe_tupa}</td>
                <td>${e.desc_tupa}</td>
                <td>${e.idperiodo}</td>
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

    let form = document.getElementById("form-partida");
    let valuesForm = ui.valuesElements(form);
   ///alert(valuesForm);
    if (ui.validateForm(valuesForm)) {
      //alert('process !!')
      let data = {
        codigo_presupuestal: valuesForm[0],
        concepto: valuesForm[1].toUpperCase(),
        importe_tupa: parseFloat(valuesForm[2]),
        desc_tupa: valuesForm[3].toUpperCase(),
        idperiodo: parseInt(valuesForm[4]),
        estado: 1
      };
      //console.log(data);
    const commanQuery =
      cod === 0
        ? createInsertQuery("partidapresupuestal", data)
        : createUpdateQuery("partidapresupuestal", data, "idpartida", cod);
    
    const result = executeQuery(
      commanQuery.query,
      commanQuery.params,
      "partidapresupuestal"
    );
    ui.clearElements(form)
    ui.initFocus(form)
    //console.log('datos insertados !')
    reload(result);
   }else {
    alert("inserte todos los datos !!!");
  }
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
    "partidapresupuestal",
    "idpartidapresupuestal",
    element.id
  );
  document.getElementById("btn-cancelar").classList.remove("u-none");
  fullData.then(items => {
    document.getElementById("cod").value = items[0].idpartidapresupuestal;
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
    "partidapresupuestal",
    data,
    "idpartida",
    id
  );
  ipcRenderer.on("MessageBox", (event, res) => {
    //res = 0 -> eliminar el registro
    //res = 1 -> no elimina nada
    if (res === 0) {
      const result = executeQuery(
        commanQuery.query,
        commanQuery.params,
        "partidapresupuestal"
      );
      reload(result);
    }
  });
};


