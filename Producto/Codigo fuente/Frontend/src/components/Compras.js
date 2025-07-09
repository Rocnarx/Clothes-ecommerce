import React, { useState, useEffect } from 'react';
import './Compras.css';
import { Apiurl } from '../services/apirest';
import { useAuth } from './Autenticacion';

const Compras = () => {
  const [compras, setCompras] = useState([]);
  const { isAuthenticated, userRole, oficialNickname } = useAuth();

  useEffect(() => {
    const fetchCompras = async () => {
      try {
        if (isAuthenticated && userRole === "cliente") {
          const urlCedula = `${Apiurl}/usuarios/username/${oficialNickname}`;
          const responseCedula = await fetch(urlCedula);

          if (!responseCedula.ok) {
            throw new Error(`Error al obtener la cédula: ${responseCedula.status}`);
          }

          const dataCedula = await responseCedula.json();
          const cedula = Number(dataCedula.body?.[0]?.cedula);  // Aseguramos que la cédula sea un número

          if (!cedula) {
            throw new Error("No se encontró la cédula para el usuario.");
          }

          // Enviar la cédula como número en el cuerpo de la solicitud POST
          const responseCompras = await fetch(`${Apiurl}/ventas/cliente`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ cedula })
          });

          if (!responseCompras.ok) {
            throw new Error('Error al obtener las compras');
          }

          const dataCompras = await responseCompras.json();
          setCompras(dataCompras);
        }
      } catch (error) {
        console.error('Error al obtener las compras:', error);
        if (error.response) {
          console.error('Detalles del error:', await error.response.json());
        }
      }
      
    };

    fetchCompras();
  }, [isAuthenticated, userRole, oficialNickname]);

  return (
    <div className="compras-container">
      <h2>Mis Compras</h2>
      {compras.length === 0 ? (
        <p>No has realizado ninguna compra aún.</p>
      ) : (
        <div className="compras-list">
          {compras.map((compra, index) => (
            <div key={index} className="compra-item">
              <h3>Compra {index + 1}</h3>
              <p><strong>ID Venta:</strong> {compra.idVenta}</p>
              <p><strong>Fecha de Compra:</strong> {new Date(compra.fechaCompra).toLocaleDateString()}</p>
              <p><strong>Total de la Compra:</strong> ${compra.totalCompra.toLocaleString()}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Compras;
