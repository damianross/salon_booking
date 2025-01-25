import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import prisma from './prisma';
import { Router } from 'express';

const bookingRouter = Router();





bookingRouter.get('/takenslots', async(req, res) => {        // Get all TAKEN slots.
    const takenSlots = await prisma.appointment.findMany({
        select: {
            time: true,
        },
        where: {
            status: {not: "CANCELED"},
            time: {
                gt: new Date()
            }
        }
    });
    res.status(200).json(takenSlots);
});

bookingRouter.post('/book', async(req, res) => {        // Book a slot.
    if(!req.body.time || !req.body.clientPhone || !req.body.clientName || !req.body.workerId) {
        res.status(400).send('Invalid request');
        return;
    }else{
        try {
        console.log('Booking request received');
        console.log(req.body);
        const newAppointment = await prisma.appointment.create({
            data: {
                time: new Date(req.body.time),
                status: "PENDING",
                clientPhone: req.body.clientPhone,
                clientName: req.body.clientName,
                workerId: req.body.workerId
            }
        });
        const uniqueLink = 'http://localhost:3000/booking/confirm?id=' + newAppointment.id;
        const sms = await fetch(`https://api.smsapi.bg/sms.do?to=${req.body.clientPhone}&message=Кликнете_линка_за_да_потвърдите_запазеният_час:_[%${uniqueLink}]&test=1`, {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + process.env.SMSAPI_TOKEN
            }
        });
        console.log(sms.body);
        res.status(201);
        } catch (err) {
            console.log(err);
            res.status(500);
        }
    }
});

bookingRouter.get('/confirmed', async(req, res) => {        // Confirm a slot.
    try {
    const appointment = await prisma.appointment.update({
        where: {
            time: {
                gt: new Date()
            },
            id: parseInt(req.query.id as string)
        },
        data: {
            status: "CONFIRMED"
        }
    });
    res.sendFile('confirmed.html', {root: __dirname + '/../public'});
    }catch (err) {
        if (err instanceof PrismaClientKnownRequestError && err.code === 'P2025') {
            res.status(404).sendFile('404.html', {root: __dirname + '/../public'});
        } else {
        res.status(500);
        console.log(err);
        }
    }
});

export default bookingRouter;