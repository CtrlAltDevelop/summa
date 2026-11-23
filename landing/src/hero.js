import * as THREE from 'three';

import { prefersReducedMotion } from './motion.js';

const DAMPING = 0.08;
const SETTLED = 0.0005;

/**
 * The "تراز" (balance) scale: a beam on a post with two pans. It tips with the
 * totals of the demo account. With reduced motion it jumps to the angle instead
 * of easing, and nothing animates on its own.
 * Returns `null` when WebGL is not available, so the page still works without it.
 * @param {HTMLCanvasElement} canvas
 */
export function createScale(canvas) {
  let renderer;
  try {
    renderer = new THREE.WebGLRenderer({ canvas, antialias: true, alpha: true });
  } catch {
    return null;
  }
  const reduced = prefersReducedMotion();
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(40, 1, 0.1, 50);
  camera.position.set(0, 0.6, 7);

  const accent = new THREE.MeshStandardMaterial({ color: 0xf7c759, roughness: 0.35, metalness: 0.4 });
  const body = new THREE.MeshStandardMaterial({ color: 0xc9c2b2, roughness: 0.45, metalness: 0.5 });
  scene.add(new THREE.AmbientLight(0xffffff, 0.7));
  const key = new THREE.DirectionalLight(0xffffff, 1.4);
  key.position.set(3, 4, 5);
  scene.add(key);

  const post = new THREE.Mesh(new THREE.CylinderGeometry(0.08, 0.12, 2.6, 24), body);
  post.position.y = -0.3;
  const base = new THREE.Mesh(new THREE.CylinderGeometry(0.9, 1.0, 0.16, 32), body);
  base.position.y = -1.6;
  const beam = new THREE.Group();
  beam.add(new THREE.Mesh(new THREE.BoxGeometry(4, 0.1, 0.1), accent));
  const pans = [-2, 2].map((x) => {
    const pan = new THREE.Mesh(new THREE.CylinderGeometry(0.7, 0.55, 0.12, 32), accent);
    pan.position.set(x, -0.9, 0);
    const cord = new THREE.Mesh(new THREE.CylinderGeometry(0.01, 0.01, 0.9, 6), body);
    cord.position.set(x, -0.45, 0);
    beam.add(pan, cord);
    return pan;
  });
  beam.position.y = 0.95;
  scene.add(post, base, beam);

  let target = 0;
  let frame = 0;

  function resize() {
    const { clientWidth: w, clientHeight: h } = canvas;
    if (!w || !h) return;
    renderer.setSize(w, h, false);
    camera.aspect = w / h;
    camera.updateProjectionMatrix();
    // Resizing clears the canvas, so draw again or it stays blank.
    draw();
  }

  function draw() {
    pans.forEach((pan) => (pan.rotation.z = -beam.rotation.z));
    renderer.render(scene, camera);
  }

  function step() {
    frame = 0;
    const delta = target - beam.rotation.z;
    if (Math.abs(delta) < SETTLED) {
      beam.rotation.z = target;
      draw();
      return;
    }
    beam.rotation.z += delta * DAMPING * 2;
    draw();
    frame = requestAnimationFrame(step);
  }

  // The canvas is created before it is on the page, so its first real size
  // arrives later; watch it rather than only the window.
  const observer = typeof ResizeObserver === 'function' ? new ResizeObserver(resize) : null;
  if (observer) observer.observe(canvas);
  else window.addEventListener('resize', resize);
  resize();
  draw();

  return {
    /** Tip the beam toward `angle` radians (positive = the right pan rises). */
    setTilt(angle) {
      target = angle;
      if (reduced) {
        beam.rotation.z = angle;
        draw();
      } else if (!frame) {
        frame = requestAnimationFrame(step);
      }
    },
    get angle() {
      return beam.rotation.z;
    },
    dispose() {
      cancelAnimationFrame(frame);
      observer?.disconnect();
      window.removeEventListener('resize', resize);
      renderer.dispose();
    },
  };
}
