import { Prisma, PrismaClient } from '@prisma/client'
import express from 'express'

const prisma = new PrismaClient()
const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.get('/workers', async (req, res) => {
  const users = await prisma.worker.findMany()
  res.json(users)
})

app.get('/workers/:id', async (req, res) => {
  const { id } = req.params
  const user = await prisma.worker.findUnique({
    where: {
      id: Number(id),
    },
  })
  res.json(user)
})

app.post('/workers', async (req, res) => {
  const { name, phone, email } = req.body
  const user = await prisma.worker.create({
    data: {
      name,
      phone,
      email,
    },
  })
  res.json(user)
})

app.put('/workers/:id', async (req, res) => {
  const { id } = req.params
  const { name, phone, email } = req.body
  const user = await prisma.worker.update({
    where: {
      id: Number(id),
    },
    data: {
      name,
      phone,
      email,
    },
  })
  res.json(user)
})


const server = app.listen(3000, () =>
  console.log(`🚀 Server ready at: http://localhost:3000`),
)