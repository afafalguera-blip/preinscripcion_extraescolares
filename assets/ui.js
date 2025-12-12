// Utilidades UI compartidas (sin dependencias)
(() => {
  const ensureToastRoot = () => {
    let root = document.getElementById("toast-root");
    if (root) return root;
    root = document.createElement("div");
    root.id = "toast-root";
    root.className = "toast-root";
    document.body.appendChild(root);
    return root;
  };

  const escapeCsv = (val) => {
    if (val === null || val === undefined) return "";
    const s = String(val);
    // Escapar comillas dobles según RFC4180
    return `"${s.replace(/"/g, '""')}"`;
  };

  const downloadCsv = (filename, rows) => {
    const content = rows.map((r) => r.map(escapeCsv).join(",")).join("\n");
    // BOM para Excel
    const blob = new Blob(["\uFEFF" + content], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    link.remove();
    setTimeout(() => URL.revokeObjectURL(link.href), 0);
  };

  const formatDateES = (dateLike) => {
    if (!dateLike) return "";
    const d = new Date(dateLike);
    if (Number.isNaN(d.getTime())) return "";
    return d.toLocaleDateString("es-ES");
  };

  const formatCurrencyEUR = (n) => {
    const num = Number(n);
    if (!Number.isFinite(num)) return "";
    return new Intl.NumberFormat("es-ES", { style: "currency", currency: "EUR" }).format(num);
  };

  const toast = (message, type = "info", opts = {}) => {
    const root = ensureToastRoot();
    const t = document.createElement("div");
    const variant =
      type === "success"
        ? "toast toast-success"
        : type === "error"
          ? "toast toast-error"
          : type === "warn"
            ? "toast toast-warn"
            : "toast toast-info";
    t.className = variant;
    t.setAttribute("role", "status");
    t.innerHTML = `<div class="toast-title">${type === "success" ? "Éxito" : type === "error" ? "Error" : type === "warn" ? "Aviso" : "Info"}</div>
<div class="toast-msg"></div>`;
    t.querySelector(".toast-msg").textContent = message;
    root.appendChild(t);
    requestAnimationFrame(() => t.classList.add("toast-in"));

    const timeout = typeof opts.timeoutMs === "number" ? opts.timeoutMs : type === "error" ? 6000 : 3200;
    const close = () => {
      t.classList.remove("toast-in");
      t.classList.add("toast-out");
      setTimeout(() => t.remove(), 180);
    };
    t.addEventListener("click", close);
    setTimeout(close, timeout);
  };

  window.ui = Object.freeze({
    toast,
    downloadCsv,
    formatDateES,
    formatCurrencyEUR
  });
})();


