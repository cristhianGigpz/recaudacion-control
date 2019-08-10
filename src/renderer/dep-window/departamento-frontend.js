import { ipcRenderer } from "electron";
import UI from "./main-window/ui";
const ui = new UI();

/**
 * Carga todos los eventos al formulario
 */
window.addEventListener("DOMContentLoaded", () => {
  LoadData();
  register();
  cancelUpdate();
});

/**
 * Inicializa los datos en el formulario
 */
const LoadData = () => {
  //const element = ui.loadGetData('departamento');
  //element.then((e)=>{LoaderData(e)})
  //cerrar formulario
  listGrilla();
  ui.closeFrom("cancel-button");
};
/**
 * Lista los datos de la tabla
 */
const listGrilla = () => {
  const dep = ui.loadGetData("departamento");
  dep.then(e => {
    LoaderData(e);
  });
};
/**
 *
 * @param {matriz departamento} items
 */
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
/**
 * Registra y Actualiza los datos a la tablas
 */
const register = () => {
  document.getElementById("btn-guardar").addEventListener("click", e => {
    e.preventDefault();
    const _name = document.getElementById("dep").value;
    let cod = parseInt(document.getElementById("cod").value);
    if (_name === 0) {
      alert("llene toda la informacion");
      return false;
    }
    let data = { nombre_departamento: _name };
    const commanQuery =
      cod === 0
        ? ui.createInsertQuery("departamento", data)
        : ui.createUpdateQuery("departamento", data, "iddepartamento", cod);
    //console.log(commanQuery.query)
    //console.log(commanQuery.params)
    //return false;
    const result = ui.executeQuery(
      commanQuery.query,
      commanQuery.params,
      "departamento"
    );
    reload(result);

    /*const element = ui.insertData('INSERT INTO departamento(nombre_departamento) VALUES($1);',[_name],'departamento');
        element.then((e)=>{LoaderData(e)})*/
  });
};

/**
 * Limpia campo del formulario
 */
const clear = () => {
  document.getElementById("dep").value = "";
  document.getElementById("cod").value = "0";
  document.getElementById("btn-cancelar").classList.add("u-none");
  document.getElementById("btn-guardar").innerText = "Guardar";
};

/**
 * Recarga la grilla
 * @param {Matriz de datos} element
 */
const reload = element => {
  element.then(e => {
    listGrilla();
    clear();
  });
};

/**
 * Cancela la actualizacion de los datos
 */
const cancelUpdate = () => {
  document.getElementById("btn-cancelar").addEventListener("click", e => {
    e.preventDefault();
    document.getElementById("btn-cancelar").classList.add("u-none");
    clear();
  });
};

/**
 * Elemento button atributo ID
 * @param {this} element
 */
const btnEditar = element => {
  const fullData = ui.loadGetDataId(
    "departamento",
    "iddepartamento",
    element.id
  );
  document.getElementById("btn-cancelar").classList.remove("u-none");
  fullData.then(items => {
    document.getElementById("cod").value = items[0].iddepartamento;
    document.getElementById("btn-guardar").innerText = "Actualizar";
    document.getElementById("dep").value = items[0].nombre_departamento;
  });
};

/**
 * Elemento button atributo ID
 * @param {this} element
 */
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
  const commanQuery = ui.createUpdateQuery(
    "departamento",
    data,
    "iddepartamento",
    id
  );
  ipcRenderer.on("MessageBox", (event, res) => {
    //res = 0 -> eliminar el registro
    //res = 1 -> no elimina nada
    if (res === 0) {
      const result = ui.executeQuery(
        commanQuery.query,
        commanQuery.params,
        "departamento"
      );
      reload(result);
    }
  });
};
