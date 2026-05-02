# AtlasCore Hub App — hub.py
# Version: 1.0
# Main hub window — central GUI for the AtlasCore ecosystem.

import tkinter as tk
from tkinter import ttk

APP_VERSION = "1.0"
APP_TITLE   = f"AtlasCore Hub  v{APP_VERSION}"


class HubApp:
    def __init__(self):
        self.root = tk.Tk()
        self._configure_window()
        self._build_ui()

    # ------------------------------------------------------------------ setup
    def _configure_window(self):
        self.root.title(APP_TITLE)
        self.root.geometry("800x500")
        self.root.resizable(True, True)
        self.root.configure(bg="#0d0d0d")

    # ------------------------------------------------------------------- UI
    def _build_ui(self):
        # ── Header ──────────────────────────────────────────────────────────
        header = tk.Frame(self.root, bg="#111111", pady=12)
        header.pack(fill="x")

        tk.Label(
            header,
            text="AtlasCore Hub",
            font=("Segoe UI", 22, "bold"),
            fg="#00d4ff",
            bg="#111111",
        ).pack()

        tk.Label(
            header,
            text=f"v{APP_VERSION}  —  Central Control",
            font=("Segoe UI", 10),
            fg="#555555",
            bg="#111111",
        ).pack()

        # ── Divider ──────────────────────────────────────────────────────────
        ttk.Separator(self.root, orient="horizontal").pack(fill="x")

        # ── Hub Panels ───────────────────────────────────────────────────────
        content = tk.Frame(self.root, bg="#0d0d0d", padx=20, pady=20)
        content.pack(fill="both", expand=True)

        panels = [
            ("Control Prime",  "Main dev machine",      "#1a1a2e"),
            ("Arctic Prime",   "Laptop / light tasks",  "#1a1a2e"),
            ("PIX",            "Phone input layer",     "#1a1a2e"),
            ("Logs",           "Changelog & activity",  "#1a1a2e"),
        ]

        for col, (title, subtitle, bg) in enumerate(panels):
            self._make_panel(content, title, subtitle, bg, col)

        content.columnconfigure(list(range(len(panels))), weight=1)

        # ── Status Bar ───────────────────────────────────────────────────────
        status = tk.Frame(self.root, bg="#111111", pady=6)
        status.pack(fill="x", side="bottom")

        tk.Label(
            status,
            text="Status: Online  |  AtlasCore Hub  v1.0",
            font=("Segoe UI", 9),
            fg="#444444",
            bg="#111111",
        ).pack()

    def _make_panel(self, parent, title, subtitle, bg, col):
        frame = tk.Frame(parent, bg=bg, padx=16, pady=16, relief="flat", bd=1)
        frame.grid(row=0, column=col, padx=8, pady=8, sticky="nsew")

        tk.Label(
            frame,
            text=title,
            font=("Segoe UI", 13, "bold"),
            fg="#00d4ff",
            bg=bg,
        ).pack(anchor="w")

        tk.Label(
            frame,
            text=subtitle,
            font=("Segoe UI", 9),
            fg="#888888",
            bg=bg,
        ).pack(anchor="w", pady=(2, 8))

        tk.Label(
            frame,
            text="—",
            font=("Segoe UI", 9),
            fg="#333333",
            bg=bg,
        ).pack(anchor="w")

    # ------------------------------------------------------------------- run
    def run(self):
        self.root.mainloop()
