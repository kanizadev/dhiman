import { onRequest } from "firebase-functions/v2/https";
import * as functionsV1 from "firebase-functions/v1";

import { db } from "./config/firebase";
import { app } from "./app";

export const api = onRequest(
  {
    region: "asia-south1",
    cors: true
  },
  app
);

export const createUserProfile = functionsV1
  .region("asia-south1")
  .auth.user()
  .onCreate(async (user) => {
    const now = new Date().toISOString();
    await db.collection("users").doc(user.uid).set(
      {
        fullName: user.displayName ?? "",
        email: user.email ?? "",
        phone: user.phoneNumber ?? "",
        role: "student",
        xpPoints: 0,
        streakDays: 0,
        createdAt: now,
        updatedAt: now
      },
      { merge: true }
    );
  });
