import type { NextFunction, Request, Response } from "express";

import { auth, db } from "../config/firebase";

const BEARER_PREFIX = "Bearer ";

function getTokenFromHeader(header?: string): string | null {
  if (!header || !header.startsWith(BEARER_PREFIX)) {
    return null;
  }
  return header.slice(BEARER_PREFIX.length);
}

export async function requireAuth(
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const token = getTokenFromHeader(req.header("authorization"));
    if (!token) {
      res.status(401).json({ error: "Missing or invalid authorization header." });
      return;
    }

    const decoded = await auth.verifyIdToken(token);
    req.user = decoded;
    next();
  } catch (_error) {
    res.status(401).json({ error: "Unauthorized." });
  }
}

export async function requireAdmin(
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const uid = req.user?.uid;
    if (!uid) {
      res.status(401).json({ error: "Unauthorized." });
      return;
    }

    const snapshot = await db.collection("users").doc(uid).get();
    const role = snapshot.data()?.role;
    if (role !== "admin") {
      res.status(403).json({ error: "Forbidden. Admin access required." });
      return;
    }
    next();
  } catch (_error) {
    res.status(500).json({ error: "Failed to validate admin access." });
  }
}
