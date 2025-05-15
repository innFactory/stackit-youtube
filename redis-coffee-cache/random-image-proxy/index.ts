import express from 'express';
import * as redis from 'redis';

const app = express();
const port = 8080;
const redisClient = redis.createClient({
    url: "rediss://a9s-brk-usr-6c01588fe4f609bcfd1e1b9a4aa52c99925e1be32808e0804097c:a9s015e7001c2e8f00d06892e9c289873221616a70e953b83768300a4edc81ffc@red37536f-master-1.data.eu01.onstackit.cloud:52062"
});
redisClient.on('error', (err) => console.log('Redis Client Error', err));
redisClient.connect();

app.get('/without-cache', async (req, res) => {
    // generate a random number between 0 and 8
    const randomNumber = await superFancyRandomNumberGenerator();

    // fetch a random image from the image-service
    const response = await fetch(`https://image-service.apps.01.cf.eu01.stackit.cloud/${randomNumber}`)
    const presignedUrl = await response.text()
    res.send(presignedUrl);
});


app.get('/cache-active', async (req, res) => {

    // generate a random number between 0 and 8
    const randomNumber = await superFancyRandomNumberGenerator();
    await redisClient.set('random-number', randomNumber);

    // fetch a random image from the image-service
    const response = await fetch(`https://image-service.apps.01.cf.eu01.stackit.cloud/${randomNumber}`)
    const presignedUrl = await response.text()
    res.send(presignedUrl);
});


async function superFancyRandomNumberGenerator() {
    // generate a random number between 0 and 8
    const randomNumber = Math.floor(Math.random() * 9);
    // simulate a long running process (sleep 2 seconds)
    await new Promise(resolve => setTimeout(resolve, 2000));
    return randomNumber;
}


app.listen(port, () => {
    return console.log(`server is listening on ${port}`);
});
