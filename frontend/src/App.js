import React, { useEffect, useState } from "react";
import axios from "axios";
import "./App.css";

function App() {
  const [files, setFiles] = useState([]);
  const [file, setFile] = useState(null);

  const API_URL = process.env.REACT_APP_API_URL;
  const CDN_URL = process.env.REACT_APP_CDN_URL;   // ✅ ADD THIS

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

  useEffect(() => {
    fetchFiles();
  }, []);

  return (
    <div className="container">
      <h1>📁 File Manager</h1>

      <div className="upload-box">
        <input type="file" onChange={(e) => setFile(e.target.files[0])} />
        <button className="btn primary" onClick={upload}>
          Upload
        </button>
      </div>

      <div className="file-list">
        {files.length === 0 ? (
          <p className="empty">No files uploaded</p>
        ) : (
          files.map((f) => (
            <div key={f.id} className="file-item">

              {/* ✅ USE CLOUDFRONT HERE */}
              <a
                href={`${CDN_URL}/${f.url}`}
                target="_blank"
                rel="noreferrer"
              >
                📄 {f.name}
              </a>

              <button
                className="btn danger"
                onClick={() => deleteFile(f.id)}
              >
                Delete
              </button>

            </div>
          ))
        )}
      </div>
    </div>
  );
}

export default App;
