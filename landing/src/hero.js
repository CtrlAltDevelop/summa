import * as THREE from 'three';

import { prefersReducedMotion } from './motion.js';

const DAMPING = 0.08;
const SETTLED = 0.0005;
const PARALLAX = 0.12; // radians the scene turns from edge to edge of the canvas

/**
 * The balance scale: a beam on a post with two pans. It tips with the totals of
 * the demo account, and turns a little with the pointer so the hero feels alive
 * without an animation loop running all the time.
 * With reduced motion it jumps to the angle instead of easing, and the pointer
 * moves nothing. Returns `null` when WebGL is not available, so the page still
 * works without it.
 * @param {HTMLCanvasElement} canvas
 */
export function createScale(canvas) {
  let renderer;
  try {
    renderer = new THREE.WebGLRenderer({ canvas, antialias: true, alpha: true });
  } catch {
    return null;
  }
  renderer.setPixelRatio(Math.min(globalThis.devicePixelRatio ?? 1, 2));
  const reduced = prefersReducedMotion();
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(38, 1, 0.1, 50);
  camera.position.set(0, 0.5, 8.6);

  const gold = new THREE.MeshStandardMaterial({
    color: 0xf7c759,
    roughness: 0.3,
    metalness: 0.85,
    emissive: 0x523200,
    emissiveIntensity: 0.95,
  });
  const steel = new THREE.MeshStandardMaterial({ color: 0x4a5062, roughness: 0.4, metalness: 0.85 });

  scene.add(new THREE.HemisphereLight(0xfff0d0, 0x14141c, 1.3));
  const key = new THREE.DirectionalLight(0xfff4de, 2.2);
  key.position.set(3.5, 5, 4);
  const rim = new THREE.DirectionalLight(0xf5b63a, 1.6);
  rim.position.set(-4, 1.5, -3);
  const fill = new THREE.PointLight(0xffd98a, 26, 14);
  fill.position.set(0, -1.2, 3.2);
  scene.add(key, rim, fill);

  // Everything tilts together for the parallax, so the pointer turns the whole
  // object rather than sliding the camera around it.
  const rig = new THREE.Group();
  const post = new THREE.Mesh(new THREE.CylinderGeometry(0.07, 0.11, 2.6, 32), steel);
  post.position.y = -0.3;
  const base = new THREE.Mesh(new THREE.CylinderGeometry(0.95, 1.05, 0.14, 48), steel);
  base.position.y = -1.6;
  const collar = new THREE.Mesh(new THREE.TorusGeometry(0.18, 0.05, 16, 40), gold);
  collar.rotation.x = Math.PI / 2;
  collar.position.y = 0.95;

  const beam = new THREE.Group();
  beam.add(new THREE.Mesh(new THREE.BoxGeometry(4, 0.09, 0.09), gold));
  const pans = [-2, 2].map((x) => {
    const pan = new THREE.Mesh(new THREE.CylinderGeometry(0.72, 0.5, 0.1, 48), gold);
    pan.position.set(x, -0.9, 0);
    const cord = new THREE.Mesh(new THREE.CylinderGeometry(0.012, 0.012, 0.9, 8), steel);
    cord.position.set(x, -0.45, 0);
    beam.add(pan, cord);
    return pan;
  });
  beam.position.y = 0.95;
  rig.add(post, base, collar, beam);
  scene.add(rig);

  let target = 0;
  let frame = 0;
  let pointer = { x: 0, y: 0 };

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
    rig.rotation.y = pointer.x * PARALLAX;
    rig.rotation.x = pointer.y * PARALLAX * 0.5;
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

  /** Pointer position as -1..1 from the middle of the canvas. */
  function onPointerMove(event) {
    const box = canvas.getBoundingClientRect();
    if (!box.width || !box.height) return;
    pointer = {
      x: ((event.clientX - box.left) / box.width) * 2 - 1,
      y: ((event.clientY - box.top) / box.height) * 2 - 1,
    };
    if (!frame) draw();
  }

  // The canvas is created before it is on the page, so its first real size
  // arrives later; watch it rather than only the window.
  const observer = typeof ResizeObserver === 'function' ? new ResizeObserver(resize) : null;
  if (observer) observer.observe(canvas);
  else window.addEventListener('resize', resize);
  if (!reduced) canvas.addEventListener('pointermove', onPointerMove);
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
      canvas.removeEventListener('pointermove', onPointerMove);
      renderer.dispose();
    },
  };
}
