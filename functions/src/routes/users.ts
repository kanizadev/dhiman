import { Router } from "express";
import { z } from "zod";

import { db } from "../config/firebase";
import { requireAdmin, requireAuth } from "../middleware/auth";

const usersRouter = Router();

const roleSchema = z.enum(["student", "teacher", "admin"]);
const examLevelSchema = z.enum(["ssc", "hsc"]).optional();

const updateProfileSchema = z.object({
  fullName: z.string().min(2).max(100).optional(),
  phone: z.string().min(6).max(20).optional(),
  institution: z.string().min(2).max(120).optional(),
  examLevel: examLevelSchema,
  department: z.string().max(80).optional(),
  board: z.string().max(80).optional(),
  academicYear: z.string().max(20).optional(),
  photoUrl: z.string().url().optional(),
  bio: z.string().max(500).optional(),
  studyGoals: z.array(z.string().max(120)).max(20).optional(),
  favoriteSubjects: z.array(z.string().max(80)).max(20).optional(),
  dreamUniversity: z.string().max(120).optional()
});

usersRouter.get("/me", requireAuth, async (req, res, next) => {
  try {
    const uid = req.user!.uid;
    const snapshot = await db.collection("users").doc(uid).get();
    if (!snapshot.exists) {
      res.status(404).json({ error: "Profile not found." });
      return;
    }

    res.json({ uid, ...snapshot.data() });
  } catch (error) {
    next(error);
  }
});

usersRouter.patch("/me", requireAuth, async (req, res, next) => {
  try {
    const payload = updateProfileSchema.parse(req.body);
    const uid = req.user!.uid;
    await db.collection("users").doc(uid).set(
      {
        ...payload,
        updatedAt: new Date().toISOString()
      },
      { merge: true }
    );

    const updated = await db.collection("users").doc(uid).get();
    res.json({ uid, ...updated.data() });
  } catch (error) {
    next(error);
  }
});

usersRouter.get("/", requireAuth, requireAdmin, async (req, res, next) => {
  try {
    const limit = Math.min(Number(req.query.limit ?? 25), 100);
    const snapshot = await db
      .collection("users")
      .orderBy("createdAt", "desc")
      .limit(Number.isNaN(limit) ? 25 : limit)
      .get();

    const users = snapshot.docs.map((doc) => ({ uid: doc.id, ...doc.data() }));
    res.json({ count: users.length, users });
  } catch (error) {
    next(error);
  }
});

usersRouter.patch(
  "/:uid/role",
  requireAuth,
  requireAdmin,
  async (req, res, next) => {
    try {
      const body = z.object({ role: roleSchema }).parse(req.body);
      const uid = req.params.uid;
      await db.collection("users").doc(uid).set(
        {
          role: body.role,
          updatedAt: new Date().toISOString()
        },
        { merge: true }
      );
      res.json({ ok: true, uid, role: body.role });
    } catch (error) {
      next(error);
    }
  }
);

export { usersRouter };
