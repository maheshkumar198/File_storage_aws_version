import React, { useEffect, useState } from "react";
import axios from "axios";
import "./App.css";

function App() {
  const [files, setFiles] = useState([]);
  const [file, setFile] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL;

  const fetchFiles = async () => {
    const res = await axios.get(`${API_URL}/api/files`);
    setFiles(res.data);
  };

  const upload = async () => {
    if (!file) return alert("Select a file");

    const formData = new FormData();
    formData.append("file", file);

    await axios.post(`${API_URL}/api/upload`, formData);
    setFile(null);
    fetchFiles();
  };

  const deleteFile = async (id) => {
    if (!window.confirm("Delete this file?")) return;
    await axios.delete(`${API_URL}/api/files/${id}`);
    fetchFiles();
  };

const downloadFile = async (id) => {
  const res = await axios.get(`${API_URL}/api/download/${id}`);
  window.open(res.data.url, "_blank");
};

  useEffect(() => {
    fetchFiles();
  }, []);

  return (
    <div className="container">
      <h1>📁 Cloud File Manager</h1>

      {/* Upload Section */}
      <div className="upload-box">
        <input type="file" onChange={(e) => setFile(e.target.files[0])} />
        <button className="btn primary" onClick={upload}>
          Upload
        </button>
      </div>

      {/* File List */}
      <div className="file-list">
        {files.length === 0 ? (
          <p className="empty">No files uploaded</p>
        ) : (
          files.map((f) => (
            <div key={f.id} className="file-item">
              <span className="file-name">📄 {f.name}</span>

              <div className="actions">
                <button
                  className="btn download"
                  onClick={() => downloadFile(f.id)}
                >
                  Download
                </button>

                <button
                  className="btn danger"
                  onClick={() => deleteFile(f.id)}
                >
                  Delete
                </button>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}

export default App;
