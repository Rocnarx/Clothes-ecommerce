import React, { useState, useEffect } from 'react';
import './EstampasPublicadas.css';
import { useAuth } from './Autenticacion'; // Asegúrate de que useAuth esté bien importado
import { Apiurl } from '../services/apirest';

const EstampasPublicadas = () => {
  const [estampas, setEstampas] = useState([]);
  const [restockValues, setRestockValues] = useState({}); // Estado para capturar valores de reabastecimiento
  const { oficialNickname } = useAuth();

  useEffect(() => {
    const fetchEstampas = async () => {
      try {
        const urlCedula = `${Apiurl}/usuarios/username/${oficialNickname}`;
        const responseCedula = await fetch(urlCedula);

        if (!responseCedula.ok) {
          throw new Error(`Error al obtener la cédula: ${responseCedula.status}`);
        }

        const dataCedula = await responseCedula.json();
        const cedula = dataCedula.body?.[0]?.cedula;

        if (!cedula) {
          throw new Error("No se encontró la cédula para el usuario activo.");
        }

        const urlEstampas = `${Apiurl}/estampas/artista/${cedula}`;
        const responseEstampas = await fetch(urlEstampas);

        if (!responseEstampas.ok) {
          throw new Error(`Error al obtener estampas: ${responseEstampas.status}`);
        }

        const dataEstampas = await responseEstampas.json();

        if (!dataEstampas.body || !Array.isArray(dataEstampas.body)) {
          throw new Error("La respuesta no contiene un array en el campo body.");
        }

        const estampas = dataEstampas.body.map((estampa) => ({
          id: estampa.codigoEstampa || null,
          nombre: estampa.nombreEstampa || "Sin nombre",
          descripcion: estampa.descripcionEstampa || "Sin descripción",
          precio: estampa.precio || "0.00",
          stock: estampa.stock || 0,
          imagen: estampa.imagen || "",
          autor: oficialNickname || "Desconocido",
        }));

        setEstampas(estampas);
      } catch (error) {
        console.error("Error al obtener las estampas:", error.message);
      }
    };

    fetchEstampas();
  }, [Apiurl, oficialNickname]);

  const borrarEstampa = async (id) => {
    try {
      const response = await fetch(`${Apiurl}/estampas/${id}`, {
        method: 'DELETE',
      });

      if (!response.ok) {
        throw new Error(`Error al borrar la estampa con ID ${id}`);
      }

      const nuevasEstampas = estampas.filter((estampa) => estampa.id !== id);
      setEstampas(nuevasEstampas);
      localStorage.setItem('estampas', JSON.stringify(nuevasEstampas));
    } catch (error) {
      console.error('Error eliminando la estampa:', error);
    }
  };

  const restock = async (estampa) => {
    const cantidad = parseInt(restockValues[estampa.id], 10);

    if (isNaN(cantidad) || cantidad <= 0) {
      alert("Ingrese un valor numérico válido mayor que 0.");
      return;
    }

    try {
      const nuevoStock = estampa.stock + cantidad; // Sumar cantidad al stock actual

      const response = await fetch(`${Apiurl}/estampas/modificarEstampa`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          codigoEstampa: estampa.id,
          stock: nuevoStock,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(`Error al modificar la estampa: ${data.error || response.statusText}`);
      }

      // Actualizar el stock en el estado
      setEstampas(estampas.map(e => e.id === estampa.id ? { ...e, stock: nuevoStock } : e));
      setRestockValues({ ...restockValues, [estampa.id]: "" }); // Limpiar el input después del restock

    } catch (error) {
      console.error('Error al actualizar la estampa:', error);
    }
  };

  return (
    <div className="estampas-container">
      <h2>Estampas Publicadas</h2>
      <div className="estampas-list">
        {estampas.length === 0 ? (
          <p>No hay estampas publicadas.</p>
        ) : (
          estampas.map((estampa) => (
            <div key={estampa.id} className="estampa-card">
              <img src={estampa.imagen} alt={estampa.nombre} className="estampa-img" />
              <div className="estampa-info">
                <h3>{estampa.nombre}</h3>
                <p>Stock actual: {estampa.stock}</p>
                <div className="botones-container">
                  <button className="borrar-btn" onClick={() => borrarEstampa(estampa.id)}>Borrar</button>
                  
                  {/* Input y botón de restock */}
                  <input
                    type="number"
                    min="1"
                    placeholder="Cantidad"
                    className="restock-input"
                    value={restockValues[estampa.id] || ""}
                    onChange={(e) => setRestockValues({ ...restockValues, [estampa.id]: e.target.value })}
                  />
                  <button className="restock-btn" onClick={() => restock(estampa)}>ReStock</button>
                </div>  
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default EstampasPublicadas;
